---
name: pipeline-review
description: "Weekly pipeline hygiene per venture: movement, stale deals, and next actions."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Sales, Pipeline, CRM, Weekly]
    related_skills: [airtable, notion]
---

# Pipeline Review

A weekly look at every sales venture's pipeline so deals don't rot and the founder
knows where to push.

## Procedure

1. **Read the registry**; for each `sales` venture, pull the full pipeline from CRM.
2. **Compute movement** vs last week where possible: new, advanced, won, lost.
3. **Flag stale deals** — no activity beyond the venture's norm — and assign each a
   concrete next action + owner/date (write back to CRM).
4. **Spot risks**: deals stuck in a stage, missing next actions, big deals gone
   quiet.
5. **Deliver** a per-venture summary plus the short list that needs the founder.

## Output shape

```
📈 Pipeline review — week of {date}
{venture}: new n · advanced n · won n ($) · lost n
  Stale (>X days): {deal} → next: … ({date})
  Needs you: {deal} — why …
```

## Rules

- Update the CRM as you go (next actions, stages) — the review should leave the
  pipeline cleaner than it found it.
- Numbers must come from the CRM; never estimate revenue.
