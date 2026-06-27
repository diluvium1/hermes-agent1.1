---
name: lead-research
description: "Surface and enrich new leads per venture, then log them to the CRM with a fit assessment."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Sales, Leads, Research, CRM]
    related_skills: [airtable, notion]
---

# Lead Research

Find and qualify leads for each sales venture, then write them to the CRM so
nothing lives only in your head.

## Procedure

1. **Read the registry.** For each `sales` venture, note its ideal customer
   (from `description`) and CRM location (`data`).
2. **Find candidates** from the sources the venture uses (inbound, referrals,
   web research, lists). Use web tools to verify each is real and reachable.
3. **Enrich** each lead: who they are, company/role, the specific reason they fit
   this venture, and a likely entry point/angle.
4. **Score fit** (high / medium / low) with a one-line why.
5. **Log to CRM** (bundled `airtable`/`notion` skill): create the record with
   stage `New`, fit score, source, and a dated first next-action. Skip duplicates.

## Output shape

```
🔎 New leads — {venture}
  • {name / company} — fit: high — angle: … — source: … → logged (CRM id)
Skipped (dupes): n
```

## Rules

- Only verifiable leads; no invented contacts or emails.
- Respect do-not-contact / opt-out flags already in the CRM.
