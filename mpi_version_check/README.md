# MPI FCP Document Version Check

Quarterly procedure that checks whether the MPI documents this project's compliance
content is built from (`mpi_document_manifest.json`) still match what's live on
mpi.govt.nz, and prompts the MediaWiki admin to update if not.

## How it works

**llamajail cron (quarterly) — the entire automated system runs here, nowhere else**

`check_mpi_versions.py`, deployed to `/usr/local/www/fcp_api/mpi_version_check/` on
llamajail, runs from cron on the 1st of Jan/Apr/Jul/Oct. For each of the 8 documents in
the manifest it downloads the live PDF from MPI and compares:
- **Version-coded docs** (the two Simply Safe & Suitable templates): extracts the
  `S39-XXXXX` card version via `pdftotext` and diffs against `last_known_version`.
- **Other docs** (no version code): diffs the MD5 of the live PDF against `last_known_md5`.

On any mismatch it:
- **Emails** `MPI_CHECK_EMAIL_TO` (from llamajail's `/usr/local/www/fcp_api/.env`) with a summary.
- **Updates the `FCP_MAIN:MPI_Document_Status` wiki page** with a banner listing what changed.
- **Writes a report** to `reports/latest.json` and `reports/report_<date>.json`.

It never modifies `mpi_document_manifest.json` — only a completed remediation does that,
so the email/banner keep reminding every quarter until the repo is actually updated.

**Memory Bank + push notification are reactive, not scheduled**

Email and the wiki banner are the real quarterly alarm and require nothing beyond
llamajail. A Memory Bank write and a Claude push notification are Claude Code
capabilities — they only exist while a session is running — so there's deliberately no
extra scheduler anywhere trying to fake that. When the email/banner surface a pending
change, open Claude Code and ask it to check FCP MPI status (or just paste the email); it
reads `reports/latest.json` over SSH, saves a Memory Bank decision doc, and you can have
it note that in the conversation. No additional infrastructure required.

## Resolving a flagged change

1. Read `reports/latest.json` (or check the wiki banner / Memory Bank doc) for what changed.
2. Update the affected repo files (schema comments, seed data, docs, PHP labels — see each
   manifest entry's `used_by` list).
3. Refresh the PDF in `MPI_FCP_DOCUMENTS/` and re-run `md5 -q <file>` / the version regex to
   get the new value.
4. Update `mpi_document_manifest.json`'s `last_known_version`/`last_known_md5` for that doc.
5. Deploy the updated manifest to llamajail (`scp mpi_document_manifest.json
   192.168.2.10:/usr/local/www/fcp_api/mpi_version_check/`).
6. Optionally re-run `check_mpi_versions.py` by hand on llamajail to confirm it now reports
   no changes and clears the wiki banner.

## Email delivery

Uses authenticated Gmail SMTP directly from Python (`smtplib`, STARTTLS on port 587,
`server.login()`) — the same pattern as the JITSU/DATACOLLECTOR `EmailManager` on
atlantis. llamajail's local `dma`/`sendmail` is NOT used: it has no `SMARTHOST`
configured and attempts unauthenticated direct-to-MX delivery, which Gmail rejects
outright (`550-5.7.26 ... sender is unauthenticated ... SPF/DKIM ... did not pass` —
confirmed by testing on 2026-08-22). `MPI_SENDER_EMAIL`/`MPI_SENDER_PASSWORD` (a Gmail
app password, not the account password) in llamajail's `.env` handle this instead.
Confirmed working end-to-end 2026-08-22 — delivered to georgemagnuson@gmail.com.

## Manual run

```bash
ssh 192.168.2.10 'cd /usr/local/www/fcp_api/mpi_version_check && python3 check_mpi_versions.py'
```

## Config (llamajail `/usr/local/www/fcp_api/.env`)

```
MPI_CHECK_EMAIL_TO=georgemagnuson@gmail.com
MPI_SENDER_EMAIL=jitsu.stuart01@gmail.com
MPI_SENDER_PASSWORD=<Gmail app password, not the account password>
MPI_SMTP_SERVER=smtp.gmail.com
MPI_SMTP_PORT=587
MEDIAWIKI_BOT_USER=Georgemagnuson
MEDIAWIKI_BOT_PASS=<same as MEDIAWIKI_PASSWORD>
MEDIAWIKI_API_URL=http://127.0.0.1/mediawiki/api.php
```
