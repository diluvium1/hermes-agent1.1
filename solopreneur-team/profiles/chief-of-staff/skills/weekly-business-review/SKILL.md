---
name: weekly-business-review
description: "Weekly portfolio review across all ventures: what moved, what's stuck, and what needs a decision this week."
version: 1.0.0
author: Solopreneur Team Kit
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Operations, Review, Orchestration, Weekly, Strategy]
    related_skills: [business-registry]
---

# Weekly Business Review

A Monday-morning portfolio review. Higher altitude than the daily brief: trends,
not tasks. Use the strongest model available (Claude) for the synthesis.

## Procedure

1. **Load the registry** (`business-registry` skill); include every venture, note
   each one's `stage`.
2. **Delegate a week-in-review** to each specialist via `delegate_task`:
   - `content-marketer`: shipped vs planned, performance signal, next week's plan.
   - `sales-crm`: pipeline movement, new/won/lost, stale deals, next-week focus.
   - `finance-admin`: revenue/expenses for the week, runway by venture, overdue.
   - `ops-support`: ticket volume + SLA, recurring issues, SOP gaps, KPI deltas.
3. **Build the portfolio view.** For each venture: one line on health
   (🟢/🟡/🔴) with the why. Then cross-venture themes (where is time/cash going,
   what's compounding, what's leaking).
4. **Surface decisions.** A short list of choices that need the founder THIS week,
   each with context and a recommendation.
5. **Deliver** the review.

## Output shape

```
📊 Weekly review — week of {date}

Portfolio health
  🟢 [venture] — <one line>
  🟡 [venture] — <one line + risk>
  🔴 [venture] — <one line + what's needed>

Themes
  • <cross-venture pattern>

Decisions for this week
  1. [venture] <decision> — recommendation: …

Numbers
  • Revenue (wk): … | Pipeline: … | Runway (tightest venture): …
```

## Rules

- Compare to the prior week where data exists; call out direction, not just level.
- Keep it scannable in 60 seconds; depth goes in the per-venture lines.
- Recommendations are opinions with reasons, not menus.
