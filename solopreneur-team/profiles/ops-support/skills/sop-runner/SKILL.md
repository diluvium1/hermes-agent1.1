---
name: sop-runner
description: "Execute a named standard operating procedure for a venture, step by step, logging the run."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Operations, SOP, Process, Automation]
    related_skills: [notion, airtable, google-workspace]
---

# SOP Runner

Run a venture's documented procedures the same reliable way every time. The SOP
library lives in the venture's Notion/Drive; this skill executes one on request.

## Procedure

1. **Identify** the venture and the SOP name (from the task prompt). Read the SOP
   from the venture's `data` location.
2. **Pre-flight:** confirm any inputs/prerequisites the SOP lists are present. If
   something is missing, stop and report exactly what's needed.
3. **Execute step by step**, using the appropriate bundled skills (`notion`,
   `airtable`, `google-workspace`) for each action. Do not skip or reorder steps.
4. **Checkpoint** on any step the SOP marks as requiring approval or that sends
   something externally — pause and surface for sign-off instead of proceeding.
5. **Log the run** (timestamp, steps completed, outputs, anything skipped/blocked)
   to the venture's ops log, and report a concise summary.

## Output shape

```
⚙️ SOP: {name} — {venture}
  ✓ step 1 … ✓ step 2 … ⏸ step 3 (needs approval: …)
  Outputs: …
  Logged to: {ops log}
```

## Rules

- Follow the SOP exactly; if it's ambiguous or missing, report rather than improvise.
- Honor approval/checkpoint steps — never auto-complete an external send.
