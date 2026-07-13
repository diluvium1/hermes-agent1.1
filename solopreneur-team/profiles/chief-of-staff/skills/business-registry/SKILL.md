---
name: business-registry
description: "Load and interpret the solopreneur's venture registry (local/businesses.yaml) before any cross-business action."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Operations, Registry, Multi-Business, Orchestration]
---

# Business Registry

The registry at `local/businesses.yaml` is the single source of truth for every
venture the founder runs. **Load it before any cross-business task.** No venture
is hardcoded anywhere else — this file drives the whole team.

## Quick Reference

| Need | Do |
|------|----|
| Read the registry | `cat local/businesses.yaml` (path is relative to the profile home) |
| Scope an operation | Include only businesses whose `operations` list contains the area (`content`/`sales`/`finance`/`ops`) |
| Respect lifecycle | Skip or soften for `stage: idea` / `winding-down` |
| Get data handles | Use each business's `data` block (Notion db, Airtable base, Drive folder) |
| Choose a channel | Use the business's `delivery.primary` unless the routine specifies otherwise |

## Procedure

1. **Read** `local/businesses.yaml`. If it's missing or still contains
   `REPLACE_ME` placeholders, report exactly which fields are unset and stop —
   do not guess business facts.
2. **Apply defaults.** Merge the top-level `defaults` (timezone, owner,
   brand_voice) into each business unless the business overrides them.
3. **Filter** to the businesses relevant to the current task by `operations` and
   `stage`.
4. **Resolve data + delivery** for each in-scope business from its `data` and
   `delivery` blocks, and read `thresholds` for any alerting logic.
5. **Hand off context.** When delegating to a specialist, pass the venture `id`,
   its description, the relevant `data` handles, and the goal — never the whole
   file.

## Notes

- The registry lives under `local/`, which `hermes profile update` never
  overwrites — the founder's edits are safe across distribution upgrades.
- Keep `id`s stable; other skills and any saved state reference businesses by id.
