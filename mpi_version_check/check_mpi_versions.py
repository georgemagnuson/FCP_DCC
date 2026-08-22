#!/usr/local/bin/python3
"""
check_mpi_versions.py — Quarterly MPI FCP document version check.

Deployed to llamajail (192.168.2.10) at /usr/local/www/fcp_api/mpi_version_check/
and run from cron. Compares the documents in mpi_document_manifest.json against
their live versions on mpi.govt.nz. On any mismatch:

  1. Emails MPI_CHECK_EMAIL_TO with a summary.
  2. Updates a banner on the MediaWiki compliance-status page (FCP_MAIN:MPI_Document_Status).
  3. Writes a JSON report to reports/latest.json for a Claude session to pick up
     later (see mpi_version_check/README.md for the acknowledge flow).

This script NEVER modifies mpi_document_manifest.json — that file only changes
as part of a completed remediation (repo/wiki/schema updated to match the new
MPI version). That keeps the alert firing every quarter until the real fix lands.

Config (read from /usr/local/www/fcp_api/.env, same file FCP API uses):
  MPI_CHECK_EMAIL_TO    — where to send the alert email
  MPI_SENDER_EMAIL      — Gmail account the alert is sent FROM (app-password auth)
  MPI_SENDER_PASSWORD   — Gmail app password for MPI_SENDER_EMAIL (NOT the account password —
                           same pattern as JITSU/DATACOLLECTOR's EmailManager on atlantis)
  MPI_SMTP_SERVER        — default smtp.gmail.com
  MPI_SMTP_PORT          — default 587 (STARTTLS)
  MEDIAWIKI_BOT_USER    — MediaWiki account used to edit the status page
  MEDIAWIKI_BOT_PASS    — password for that account
  MEDIAWIKI_API_URL     — e.g. http://127.0.0.1/mediawiki/api.php
"""

import hashlib
import json
import os
import re
import smtplib
import subprocess
import sys
import tempfile
import time
from datetime import datetime, timezone
from email.mime.text import MIMEText
from pathlib import Path

import requests

# MPI's site sits behind an Incapsula WAF that serves an HTML challenge page
# instead of the PDF for requests it doesn't like (no browser-like User-Agent,
# or too many requests in a short window). A real quarterly run is 8 requests
# months apart, but be a reasonably well-behaved client anyway, and — critically
# — detect the challenge page via Content-Type rather than trusting the bytes.
REQUEST_HEADERS = {
    "User-Agent": ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"),
    "Accept": "application/pdf,*/*",
}
REQUEST_DELAY_SECONDS = 5

BASE_DIR = Path(__file__).resolve().parent
MANIFEST_PATH = BASE_DIR / "mpi_document_manifest.json"
REPORTS_DIR = BASE_DIR / "reports"
ENV_PATH = Path("/usr/local/www/fcp_api/.env")
WIKI_STATUS_PAGE = "FCP_MAIN:MPI_Document_Status"


def load_env(path: Path) -> dict:
    env = {}
    if not path.exists():
        return env
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, v = line.split("=", 1)
        env[k.strip()] = v.strip()
    return env


def md5_of(path: Path) -> str:
    h = hashlib.md5()
    h.update(path.read_bytes())
    return h.hexdigest()


def extract_version(pdf_path: Path, pattern: str) -> str | None:
    try:
        text = subprocess.run(
            ["pdftotext", "-l", "3", str(pdf_path), "-"],
            capture_output=True, text=True, timeout=30,
        ).stdout
    except Exception:
        return None
    m = re.search(pattern, text)
    return m.group(0) if m else None


def check_document(doc: dict, tmpdir: Path) -> dict | None:
    """Returns a change dict if the live doc differs from the manifest, else None."""
    dest = tmpdir / doc["filename"]
    try:
        resp = requests.get(doc["url"], headers=REQUEST_HEADERS, timeout=30, allow_redirects=True)
        resp.raise_for_status()
        content_type = resp.headers.get("Content-Type", "")
        if "pdf" not in content_type.lower():
            # Almost certainly the Incapsula WAF challenge page, not the document.
            return {
                "id": doc["id"], "name": doc["name"], "status": "ERROR",
                "detail": (f"Response was not a PDF (Content-Type: {content_type!r}, "
                           f"{len(resp.content)} bytes) — likely blocked by MPI's WAF. "
                           "Not compared; will retry next run."),
            }
        dest.write_bytes(resp.content)
    except Exception as e:
        return {
            "id": doc["id"], "name": doc["name"], "status": "ERROR",
            "detail": f"Could not fetch live document: {e}",
        }

    if doc.get("version_pattern"):
        live_version = extract_version(dest, doc["version_pattern"])
        if live_version and live_version != doc.get("last_known_version"):
            return {
                "id": doc["id"], "name": doc["name"], "status": "VERSION_CHANGED",
                "old_version": doc.get("last_known_version"),
                "new_version": live_version,
                "url": doc["url"],
            }
        return None

    live_md5 = md5_of(dest)
    if live_md5 != doc.get("last_known_md5"):
        return {
            "id": doc["id"], "name": doc["name"], "status": "CONTENT_CHANGED",
            "old_md5": doc.get("last_known_md5"), "new_md5": live_md5,
            "url": doc["url"],
        }
    return None


def send_email(env: dict, changes: list[dict]) -> None:
    to_addr = env.get("MPI_CHECK_EMAIL_TO")
    if not to_addr:
        print("MPI_CHECK_EMAIL_TO not set — skipping email", file=sys.stderr)
        return
    real_changes = [c for c in changes if c["status"] in ("VERSION_CHANGED", "CONTENT_CHANGED")]
    errors = [c for c in changes if c["status"] == "ERROR"]

    lines = ["MPI FCP document version check results:\n"]
    for c in real_changes:
        if c["status"] == "VERSION_CHANGED":
            lines.append(f"- {c['name']} (doc {c['id']}): {c['old_version']} -> {c['new_version']}\n  {c['url']}")
        else:
            lines.append(f"- {c['name']} (doc {c['id']}): content changed (no version code on this doc)\n  {c['url']}")
    if real_changes:
        lines.append("\nAction needed: review FCP_DCC/mpi_version_check/reports/latest.json and "
                      "update the repo (schema/seed/docs/wiki) to match, then update "
                      "mpi_document_manifest.json to close this out.")
    if errors:
        lines.append(f"\nCould not check {len(errors)} document(s) (likely MPI's WAF/rate-limit — "
                      "should clear by next run):")
        for c in errors:
            lines.append(f"- {c['name']} (doc {c['id']}): {c.get('detail', '')}")
    body = "\n".join(lines)

    if real_changes:
        subject = f"[FCP] MPI document version check: {len(real_changes)} change(s) found"
    else:
        subject = f"[FCP] MPI document version check: {len(errors)} document(s) could not be checked"

    smtp_server = env.get("MPI_SMTP_SERVER", "smtp.gmail.com")
    smtp_port = int(env.get("MPI_SMTP_PORT", "587"))
    sender_email = env.get("MPI_SENDER_EMAIL")
    sender_password = env.get("MPI_SENDER_PASSWORD")
    if not sender_email or not sender_password:
        print("MPI_SENDER_EMAIL/MPI_SENDER_PASSWORD not set — skipping email", file=sys.stderr)
        return

    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = sender_email
    msg["To"] = to_addr

    # Authenticated Gmail SMTP (app password), same pattern as the JITSU/DATACOLLECTOR
    # notifiers on atlantis — llamajail's local sendmail/dma has no relay configured and
    # Gmail rejects unauthenticated direct-to-MX delivery outright.
    try:
        with smtplib.SMTP(smtp_server, smtp_port, timeout=20) as server:
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, to_addr, msg.as_string())
    except Exception as e:
        print(f"Email send failed: {e}", file=sys.stderr)


def update_wiki_banner(env: dict, changes: list[dict]) -> None:
    api_url = env.get("MEDIAWIKI_API_URL", "http://127.0.0.1/mediawiki/api.php")
    user = env.get("MEDIAWIKI_BOT_USER")
    password = env.get("MEDIAWIKI_BOT_PASS")
    if not user or not password:
        print("MEDIAWIKI_BOT_USER/PASS not set — skipping wiki banner", file=sys.stderr)
        return

    session = requests.Session()
    try:
        r = session.get(api_url, params={"action": "query", "meta": "tokens",
                                          "type": "login", "format": "json"}, timeout=15)
        login_token = r.json()["query"]["tokens"]["logintoken"]
        r = session.post(api_url, data={"action": "login", "lgname": user,
                                         "lgpassword": password, "lgtoken": login_token,
                                         "format": "json"}, timeout=15)
        if r.json().get("login", {}).get("result") != "Success":
            print(f"Wiki login failed: {r.json()}", file=sys.stderr)
            return

        r = session.get(api_url, params={"action": "query", "meta": "tokens",
                                          "format": "json"}, timeout=15)
        csrf_token = r.json()["query"]["tokens"]["csrftoken"]

        real_changes = [c for c in changes if c["status"] in ("VERSION_CHANGED", "CONTENT_CHANGED")]
        errors = [c for c in changes if c["status"] == "ERROR"]

        rows = "\n".join(
            f"| {c['name']} || {c.get('old_version', c.get('old_md5', '?'))} "
            f"|| {c.get('new_version', c.get('new_md5', '?'))} || [{c.get('url', '')} MPI link] |-"
            for c in real_changes
        )
        error_lines = "\n".join(f"* {c['name']}: {c.get('detail', 'unknown error')}" for c in errors)

        sections = [f"'''Checked:''' {datetime.now(timezone.utc).isoformat()}Z\n"]
        if real_changes:
            sections.append(f"""{{| class="wikitable"
! Document !! Was !! Now !! Source
|-
{rows}
|}}

To resolve: update the repo (schema/seed/docs) to match the new MPI content, refresh the
PDF in <code>MPI_FCP_DOCUMENTS/</code>, then update <code>mpi_document_manifest.json</code>.
""")
        if errors:
            sections.append(f"\n'''Could not check ({len(errors)} document(s)):'''\n{error_lines}\n")
        content = "\n".join(sections)

        if real_changes:
            heading = "== ⚠️ MPI Document Update Pending =="
        elif errors:
            heading = "== ⚠️ MPI Version Check Incomplete (fetch errors) =="
        else:
            heading = "== ✅ MPI Documents Up To Date =="
        page_body = f"{heading}\n\n{content}"

        session.post(api_url, data={
            "action": "edit", "title": WIKI_STATUS_PAGE, "text": page_body,
            "summary": "Automated MPI version check", "token": csrf_token,
            "format": "json",
        }, timeout=15)
    except Exception as e:
        print(f"Wiki banner update failed: {e}", file=sys.stderr)


def write_report(changes: list[dict]) -> Path:
    REPORTS_DIR.mkdir(exist_ok=True)
    report = {
        "checked_at": datetime.now(timezone.utc).isoformat() + "Z",
        "changes": changes,
        "acknowledged": False,
    }
    stamp = datetime.now(timezone.utc).strftime("%Y%m%d")
    dated_path = REPORTS_DIR / f"report_{stamp}.json"
    dated_path.write_text(json.dumps(report, indent=2))

    latest_path = REPORTS_DIR / "latest.json"
    if changes:
        # Preserve acknowledged state across runs that find the SAME unresolved changes.
        if latest_path.exists():
            try:
                prev = json.loads(latest_path.read_text())
                if prev.get("changes") == changes:
                    report["acknowledged"] = prev.get("acknowledged", False)
            except Exception:
                pass
        latest_path.write_text(json.dumps(report, indent=2))
    else:
        latest_path.write_text(json.dumps(report, indent=2))
    return dated_path


def main() -> int:
    env = load_env(ENV_PATH)
    manifest = json.loads(MANIFEST_PATH.read_text())

    changes = []
    with tempfile.TemporaryDirectory() as td:
        tmpdir = Path(td)
        for i, doc in enumerate(manifest["documents"]):
            if i > 0:
                time.sleep(REQUEST_DELAY_SECONDS)
            result = check_document(doc, tmpdir)
            if result:
                changes.append(result)

    report_path = write_report(changes)
    print(f"Report written: {report_path}")

    if changes:
        print(f"{len(changes)} change(s) found — notifying")
        send_email(env, changes)
        update_wiki_banner(env, changes)
    else:
        print("No changes found")
        update_wiki_banner(env, changes)

    return 0


if __name__ == "__main__":
    sys.exit(main())
