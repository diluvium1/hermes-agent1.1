# Solopreneur Agent Team

A ready-to-run **team of Hermes agents** for a solopreneur operating multiple
business ventures at once. One orchestrator + four functional specialists,
shipped as committed [profile distributions](../website/docs/user-guide/profile-distributions.md)
with documented SOPs (skills) and scheduled routines (cron). Built so the *same*
agents run *every* business — you describe the ventures once, the team reuses the
systems everywhere.

## The team

| Agent | Role | Default model |
|---|---|---|
| **chief-of-staff** | Orchestrator. Reads the business registry, owns your daily/weekly cadence, **delegates** to the specialists and rolls their work into one brief. | Claude |
| **content-marketer** | Content & marketing across ventures — newsletters (e.g. Launchly Digest), content calendars, repurposing. | Gemini (Claude polish) |
| **sales-crm** | Lead gen, outreach drafts, pipeline hygiene. | Gemini |
| **finance-admin** | Invoicing, revenue/expense tracking, runway alerts. | Claude |
| **ops-support** | Support triage, SOP execution, weekly KPI reporting. | Gemini |

Each specialist's skills are the **repeatable systems** — markdown SOPs the agent
follows the same way every time. The orchestrator delegates cross-business tasks
to specialists (Hermes' `delegate_task` with `role="orchestrator"`).

## How it works

- **One source of truth: `businesses.yaml`.** Every agent reads it before acting.
  No venture is hardcoded in any skill — add/remove businesses by editing this one
  file. The named ventures (Launchly, Launchly Digest, Paranormal Gaia, Praxis,
  Glass and Counsel, J3P0) are pre-seeded as editable placeholders.
- **Profiles are isolated agents.** Each has its own identity (`SOUL.md`), model
  (`config.yaml`), skills, cron jobs, and memory.
- **Distributions make it repeatable.** Each `profiles/<agent>/` is a self-contained
  distribution; `setup.sh` installs them locally, but you can also push any one to
  its own git repo and `hermes profile update` it across machines.

## Quick start

```bash
cd examples/solopreneur-team
./setup.sh                       # installs all 5 agents + schedules routines
# ./setup.sh --no-cron           # profiles only, no scheduling

# then, as printed by setup.sh:
#   1) fill in each agent's .env (API keys + delivery tokens)
#   2) edit ~/.hermes/profiles/*/local/businesses.yaml
#   3) hermes gateway start
```

Prerequisites: Hermes installed and `hermes setup` run once. The agents use the
bundled `notion`, `airtable`, and `google-workspace` skills for data access, so
configure those integrations' keys in each agent's `.env`.

## Customizing

- **Add a business:** edit the ONE canonical registry at
  `~/.hermes/profiles/chief-of-staff/local/businesses.yaml` (the specialists
  symlink to it, so a single edit updates the whole team). Give each venture a
  lowercase `id` and list which `operations` apply — no skill edits needed.
- **Change a model:** the Claude agents (`chief-of-staff`, `finance-admin`) ship on
  `anthropic/claude-opus-4.7` and the Gemini agents (`content-marketer`, `sales-crm`,
  `ops-support`) on `google/gemini-2.5-flash`. Set `model.default` to whatever your
  API plan/provider serves (edit `config.yaml` or run `/model` in
  `hermes -p <agent> chat`). The kit is model-agnostic (`provider: auto`).
- **Change a schedule or delivery:** `hermes -p <agent> cron edit <job_id> --schedule "..." --deliver slack`, or edit `setup.sh` and re-run.
- **Add an SOP:** drop a new `skills/<name>/SKILL.md` into a profile and attach it
  to a cron job with `--skill <name>`.

## Delivery & the `[SILENT]` pattern

Routines deliver to `telegram`, `slack`, `discord`, or `email` (configure tokens
in each `.env`). Watchdog-style jobs (runway check, support triage) reply with
exactly `[SILENT]` when there's nothing to report, so you only get pinged when
something actually needs you.

## Layout

```
solopreneur-team/
├── README.md
├── setup.sh                  # installer (idempotent)
├── businesses.example.yaml   # the venture registry you fill in
└── profiles/
    ├── chief-of-staff/       # orchestrator distribution
    ├── content-marketer/
    ├── sales-crm/
    ├── finance-admin/
    └── ops-support/
```
