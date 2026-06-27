---
name: runway-alert
description: "Watchdog: alert only when a venture drops below its runway threshold or has overdue receivables; otherwise [SILENT]."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Finance, Runway, Alert, Watchdog]
    related_skills: [airtable, notion, google-workspace]
---

# Runway Alert

A quiet watchdog. It speaks only when money needs attention, so the founder can
trust that silence means "fine."

## Procedure

1. **Read the registry**; get `thresholds.runway_alert_months` and
   `thresholds.invoice_overdue_days`.
2. **For each `finance` venture**, compute runway = current cash ÷ average monthly
   burn (from recorded figures), and find receivables overdue past the threshold.
3. **Decide:**
   - If every venture is at/above its runway threshold AND nothing is overdue →
     respond with **exactly** `[SILENT]` and nothing else.
   - Otherwise → alert with specifics and a recommended action per issue.

## Output shape (only when not silent)

```
⚠️ Finance alert
  • [venture] runway {n.n} mo (< {threshold}) — burn $…/mo, cash $… → action: …
  • [venture] overdue: {client} $… ({d} days) → action: send reminder
```

## Rules

- The `[SILENT]` reply must be the entire output when all-clear (the scheduler
  suppresses delivery on `[SILENT]`).
- Never estimate cash or burn; if a venture's figures are missing, that itself is
  the alert ("runway unknown — figures not recorded").
