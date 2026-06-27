---
name: support-triage
description: "Watchdog triage of incoming support across ventures: categorize, draft replies, escalate SLA breaches; [SILENT] when clear."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Operations, Support, Triage, Watchdog]
    related_skills: [notion, airtable]
---

# Support Triage

Keep the support queue moving without spamming the founder. Run often; speak only
when there's something new or at risk.

## Procedure

1. **Read the registry**; for each `ops` venture get its ticket source and
   `thresholds.support_sla_hours`.
2. **Scan for** new/unhandled tickets and any open ticket approaching/breaching SLA.
3. **If nothing new and nothing breaching** → respond with **exactly** `[SILENT]`.
4. **Otherwise, per ticket:**
   - Categorize (question / bug / billing / feature / other) and set priority.
   - Draft a reply in the venture's voice; queue it (don't send).
   - For SLA breaches or anything needing a policy call (refund, exception),
     escalate explicitly.
   - Update the ticket record (category, priority, next action).

## Output shape (only when not silent)

```
🎫 Support triage — {venture}
  New: n   Breaching SLA: m
  • {ticket} [billing/high] → draft queued; needs founder: refund decision
```

## Rules

- `[SILENT]` must be the whole output when all-clear.
- Never send to customers automatically; never promise refunds/timelines the
  founder hasn't approved.
