---
name: pnl-digest
description: "Weekly revenue/expense digest per venture and combined, from recorded figures only."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Finance, P&L, Reporting, Weekly]
    related_skills: [airtable, notion, google-workspace]
---

# P&L Digest

A weekly money snapshot: what came in, what went out, per venture and across the
portfolio.

## Procedure

1. **Read the registry**; for each `finance` venture, pull this week's revenue and
   expenses from its `data` source.
2. **Compute** per venture: revenue, expenses, net, and delta vs last week.
3. **Aggregate** the portfolio totals.
4. **Call out** anything notable: a venture flipped negative, an unusual expense, a
   big payment received, runway implications (hand the detail to `runway-alert` if
   a threshold is breached).
5. **Deliver** the digest. Keep it scannable; show the math behind totals.

## Output shape

```
💰 P&L digest — week of {date}
{venture}: rev $… · exp $… · net $… ({+/-} vs last wk)
…
Portfolio: rev $… · exp $… · net $…
Notable: …
```

## Rules

- Every figure from recorded data; mark gaps as "not recorded", never estimate.
- Distinguish cash vs accrual only if the source does; otherwise state which.
