---
name: content-calendar
description: "Keep each venture's content calendar full: find gaps in the next 7 days and draft fillers."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Content, Calendar, Planning, Marketing]
    related_skills: [notion, airtable]
---

# Content Calendar

Make sure no content venture goes dark. Check the next 7 days, surface gaps, and
draft enough to fill them.

## Procedure

1. **Read the registry.** For each `content` venture, open its calendar (Notion db
   or Airtable base from `data`).
2. **Scan the next 7 days** per channel the venture posts on. A "gap" is any
   planned slot that's empty or any expected cadence with no scheduled item.
3. **Propose fillers** for each gap, on-brand, ideally repurposed from existing
   anchor content (see the `content-repurpose` skill). Draft them, don't just title.
4. **Write back** proposed items to the calendar as `Draft` status (never
   auto-publish) and report the before/after coverage.

## Output shape

```
🗓️ Content coverage — next 7 days
{venture}
  Mon ✅  Tue ⬜(filled→draft)  Wed ✅  …
  Drafted: <n> items → saved to {calendar}
Gaps still open (need input): …
```

## Rules

- Respect each venture's cadence and channels from the registry.
- Flag, don't fabricate, anything that needs a real asset or the founder's input.
