# Alcohol Licensing Documents

Local reference copies for compliance under the **Sale and Supply of Alcohol Act 2012** (NZ),
separate from the MPI Food Control Plan documents in `../MPI_FCP_DOCUMENTS/`. This
covers licensing/legal obligations for restaurants serving alcohol under an on-licence
(different regulator, renewal cycle, and document set than the food safety FCP).

**Source page:** https://resources.alcohol.org.nz/alcohol-management-laws/nz-alcohol-laws/sale-and-supply-of-alcohol-act-2012

## Contents

| File | Description |
|---|---|
| `Sale-and-Supply-of-Alcohol-Act-2012-reprint-2026-04-05.pdf` | Full Act text, current reprint as of 2026-04-05, from legislation.govt.nz |
| `Sale-and-Supply-of-Alcohol-Regulations-2013.pdf` | Regulations made under the Act (current version as at 2026-05-28) — approved evidence of age documents, manager's certificate qualifications, LAP process detail, etc. The Act itself delegates several definitions (e.g. "approved evidence of age document") to this Regulations document rather than spelling them out |
| `National-Guidance-Alcohol-Promotions-Off-Licensed-Premises-2016.pdf` | National guidance on alcohol promotions — off-licensed premises (Nov 2016) |
| `National-Guidance-Alcohol-Promotions-On-Licensed-Premises-2016.pdf` | National guidance on alcohol promotions — on-licensed premises (Nov 2016) — most directly relevant to a restaurant on-licence |
| `National-Guidance-Remote-Sales-of-Alcohol.pdf` | National guidance on remote (online/delivery) sales of alcohol |
| `Dunedin-Local-Alcohol-Policy-2019.pdf` | Dunedin City Council's Local Alcohol Policy (LAP), in effect since Feb 2019 — local trading-hour limits and licence conditions on top of the national Act |
| `Dunedin-LAP-Summary-of-Changes.pdf` | One-page summary table comparing the pre-LAP Sale of Liquor Policy to the adopted LAP |

## Dunedin-specific rules (on top of the national Act)

Source: https://www.dunedin.govt.nz/council/policies,-plans-and-strategies/policies/local-alcohol-policy (site is Cloudflare-protected — see Notes below)

The DCC LAP sets **maximum trading hours** for on-licence restaurants/cafés in non-residential
areas at **Monday–Sunday, 8am to 1am the following day** — tighter than hotels/taverns (8am–3am
with a 2:30am one-way door) but looser than premises in/adjacent to residential areas (9am–11pm
Sun–Thu, 9am–midnight Fri/Sat). See LAP section 5.1.1 for the full table by premises type/area.

The District Licensing Committee (DLC) can also impose **discretionary conditions** under Act
sections 110 and 117 — e.g. management of outdoor seating/footpath space, BYO management, CCTV/
security, a "Premises Management Plan" addressing intoxication prevention and management of
multiple-drink purchases (incl. shots). See LAP section 5.1.2–5.1.3.

**Status:** As of the March 2026 council workshop, DCC has an active LAP *review* underway but it
is still at early-stage consultation — the 2019 policy above remains the one currently in force.
Re-check the source page periodically since a new/updated policy could change these hours.

## Notes

- The Act reprint is a point-in-time snapshot — legislation.govt.nz republishes reprints as amendments take effect, so re-check the source page periodically for a newer date-stamped PDF rather than assuming this one stays current indefinitely.
- `resources.alcohol.org.nz` sits behind a CloudFront/WAF check that returns 403 to a plain `curl` — fetch with a browser-like `User-Agent` and a `Referer` header set to the source page above (see Memory Bank for the working command).
- `dunedin.govt.nz` sits behind a Cloudflare JS challenge that blocks `curl`/WebFetch entirely (not fixable with headers) — use the Chrome browser extension (`claude-in-chrome`) to fetch anything from this site: navigate there, find the real PDF asset link with a DOM query (the page's visible link text doesn't match its `href`), then either click the link and use the PDF viewer's own download button, or `fetch()` the URL in-page and trigger a synthetic download — but only one synthetic download per page load; a second one is silently blocked by Chrome's multi-download protection, so click a real link for any subsequent files.
- See Memory Bank for full context on why this folder exists and the key licensing obligations relevant to on-licence restaurants.
