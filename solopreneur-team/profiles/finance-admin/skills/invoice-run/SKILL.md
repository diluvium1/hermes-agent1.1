---
name: invoice-run
description: "Generate and queue each venture's due invoices and flag overdue ones, per registry finance settings."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Finance, Invoicing, Admin, Monthly]
    related_skills: [airtable, notion, google-workspace]
---

# Invoice Run

Produce the invoices due this cycle and surface anything overdue — drafts only,
the founder approves and sends.

## Procedure

1. **Read the registry.** For each `finance` venture, read its `finance` block
   (`invoice_cadence`, `payment_terms`) and `data` location.
2. **Determine what's due** this run: recurring clients/retainers due now, plus any
   completed work awaiting invoicing (from the venture's billing source).
3. **Draft each invoice** with line items, amounts (from recorded figures only),
   terms, and due date = issue date + `payment_terms`. Save as `Draft`.
4. **Scan receivables** for invoices past due by more than
   `thresholds.invoice_overdue_days`; draft a polite reminder for each.
5. **Report** the run: drafted invoices (count + total per venture), overdue
   reminders queued, and anything that needs founder input (e.g. missing amount).

## Output shape

```
🧾 Invoice run — {month}
{venture}: drafted n ($ total) · overdue reminders m
  Needs input: {client} — amount not recorded
All drafts saved to: {billing location} (status: Draft)
```

## Rules

- Never send. Drafts + queue only.
- Amounts must come from recorded data; flag, don't invent, missing figures.
