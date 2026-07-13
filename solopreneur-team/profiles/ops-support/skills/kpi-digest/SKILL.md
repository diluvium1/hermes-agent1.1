---
name: kpi-digest
description: "Weekly operational KPI digest per venture from recorded data, with week-over-week trends."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Operations, KPI, Reporting, Weekly]
    related_skills: [notion, airtable, google-workspace]
---

# KPI Digest

A weekly operational readout per venture — the few numbers that tell the founder
whether ops is healthy.

## Procedure

1. **Read the registry**; for each `ops` venture, pull this week's operational
   metrics from its `data` source. Typical KPIs: tickets opened/closed, avg
   response time, SLA-met %, fulfillment/turnaround, churn or refunds, uptime.
2. **Compute trend** vs last week for each KPI.
3. **Flag** anything trending the wrong way or breaching a threshold, with a likely
   cause and a suggested fix (or an SOP to run via `sop-runner`).
4. **Deliver** a compact per-venture table plus a one-line health call.

## Output shape

```
📋 Ops KPIs — week of {date}
{venture} — health: 🟢/🟡/🔴
  tickets: opened n / closed n | resp: …h ({+/-}) | SLA-met: …% ({+/-})
  Flag: {KPI} worsening → likely {cause} → suggest {fix/SOP}
```

## Rules

- Only recorded metrics; mark gaps as "not tracked", never estimate.
- Trends over levels — always compare to the prior week when data exists.
