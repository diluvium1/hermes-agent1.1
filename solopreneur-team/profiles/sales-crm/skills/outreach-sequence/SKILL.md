---
name: outreach-sequence
description: "Draft today's outreach and follow-ups per venture from CRM next-actions — queued for approval, never sent."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Sales, Outreach, Follow-up, CRM]
    related_skills: [airtable, notion, google-workspace]
---

# Outreach Sequence

Turn today's due CRM actions into ready-to-send drafts so the founder just reviews
and hits send.

## Procedure

1. **Read the registry**; for each `sales` venture, query the CRM for contacts
   whose `next action` is due today or overdue.
2. **For each**, determine the right touch: first-touch, value follow-up, check-in,
   or break-up. Use prior context on the record so follow-ups reference real
   history (no "just bumping this").
3. **Draft** in the venture's voice — personalized opener, one clear ask, easy out.
   Keep it short.
4. **Queue, don't send.** Save each draft against its CRM record and set the next
   action + date for after this touch.
5. **Report** the batch with per-draft status.

## Output shape

```
✍️ Outreach drafts — {venture} ({date})
  • {contact} [follow-up #2] → draft ready; next action set {date}
    ─ subject: …
    ─ body: …
Queued: n   Needs founder input: m
```

## Rules

- Never auto-send. Drafts + queue only.
- One ask per message; respect opt-outs.
