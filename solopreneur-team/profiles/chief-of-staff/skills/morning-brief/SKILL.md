---
name: morning-brief
description: "Produce one prioritized daily brief across all ventures by delegating to specialists and synthesizing."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Operations, Briefing, Orchestration, Daily]
    related_skills: [business-registry]
---

# Morning Brief

Deliver the founder ONE prioritized brief for the day across every active venture.
You orchestrate; specialists fetch the detail.

## Procedure

1. **Load the registry** (use the `business-registry` skill). Scope to
   `stage: active` ventures.
2. **Delegate in parallel** with `delegate_task` (you run as orchestrator). Hand
   each specialist a focused, same-shape ask:
   - `sales-crm`: "Top 3 things needing action today across these ventures: …"
   - `finance-admin`: "Anything due, overdue, or below runway threshold today?"
   - `ops-support`: "Open tickets breaching/approaching SLA, and today's SOPs."
   - `content-marketer`: "Anything publishing today or a content gap in next 48h."
   Pass each only the venture ids + data handles it needs.
3. **Collect & dedupe.** Merge results; drop noise; group by venture only if it
   aids clarity.
4. **Prioritize** into three tiers:
   - **Decide today** — needs the founder's call (with the specific options).
   - **FYI** — happening, no action needed.
   - **Handled** — what the team already did/queued.
5. **Deliver** a tight brief. Lead with "Decide today." End with an ordered
   "What I'd do next" (max 5). If there is genuinely nothing that needs the
   founder, say so in one line.

## Output shape

```
☀️ Morning brief — {date}

🔴 Decide today
  • [venture] <decision> — options: A / B (my pick: A, because …)

🟡 FYI
  • [venture] <thing>

✅ Handled
  • [venture] <what the team did>

▶️ What I'd do next
  1. …
```

## Rules

- Be specific: name ventures, cite the Notion/Airtable records used.
- Never invent. If a specialist couldn't get data, say what's blocked.
