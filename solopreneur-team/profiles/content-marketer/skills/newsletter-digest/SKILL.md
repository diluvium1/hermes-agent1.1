---
name: newsletter-digest
description: "Build a ready-to-send newsletter issue (e.g. Launchly Digest) from a venture's content settings and sources."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Content, Newsletter, Marketing, Weekly]
    related_skills: [notion, google-workspace, content-calendar]
---

# Newsletter Digest

Build a finished newsletter issue for any venture with a `content` block (cadence,
send_day, sections). The flagship case is **Launchly Digest**, but this works for
any venture's recurring email.

## Procedure

1. **Read the registry.** For each venture in scope whose content cadence is due
   (e.g. today is its `send_day`), pull its `content.sections`, `brand_voice`, and
   `data` (Notion db / Drive folder).
2. **Gather material.** From the venture's content calendar (bundled `notion`/
   `airtable` skills) and any source list, collect candidate items for this issue.
   If the venture curates external links, fetch and verify each one.
3. **Draft to the section template.** Fill every section in `content.sections`
   in the venture's voice. Tight intro, scannable picks, one clear CTA / "one ask."
4. **Self-edit.** Subject line + preview text (A/B two options). Cut filler. Check
   every link resolves. Mark any missing fact as `[[NEEDS: …]]`.
5. **Queue, don't send.** Save the draft to the venture's Drive/Notion location,
   and output the issue plus a one-line "ready to send / blocked on X" status.

## Output shape

```
✉️ {venture} — issue for {date}
Subject (A): …
Subject (B): …
Preview: …
---
{rendered issue, by section}
---
Status: ready to send  |  blocked: [[NEEDS: …]]
Saved to: {notion/drive location}
```

## Rules

- Never auto-send. Draft + queue + surface for approval.
- One issue per due venture; don't blend ventures.
