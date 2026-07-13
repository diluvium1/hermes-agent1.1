#!/usr/bin/env bash
# =============================================================================
# Solopreneur Agent Team — one-shot installer
# =============================================================================
# Installs the 5 Hermes profiles (1 orchestrator + 4 specialists) from this
# directory, seeds the shared business registry into each, and schedules the
# recurring routines. Safe to re-run: profiles are re-installed with --force and
# cron jobs are only created if a job of the same name does not already exist.
#
#   Usage:
#     ./setup.sh            # install everything
#     ./setup.sh --no-cron  # install profiles only, skip scheduling
#
# Prerequisites: `hermes` on PATH, and a configured Hermes home (`hermes setup`).
# Fill in API keys per profile (.env) and edit local/businesses.yaml AFTER this
# runs — see the printed next-steps.
# -----------------------------------------------------------------------------
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_DIR="$HERE/profiles"
REGISTRY_SRC="$HERE/businesses.example.yaml"
# Repo's bundled skills live one level up (this kit ships inside hermes-agent).
BUNDLED_SKILLS_SRC="$HERE/../skills/productivity"
WITH_CRON=1
[[ "${1:-}" == "--no-cron" ]] && WITH_CRON=0

PROFILE_NAMES=(chief-of-staff content-marketer sales-crm finance-admin ops-support)

# Data skills each specialist's SOPs call. A distribution install ships only the
# profile's own skills/, so these bundled skills are vendored in per specialist.
DATA_SKILLS=(notion airtable google-workspace)

command -v hermes >/dev/null 2>&1 || { echo "ERROR: 'hermes' not found on PATH. Install Hermes and run 'hermes setup' first."; exit 1; }

# Resolve a profile's home directory so we can drop the registry into local/.
profile_home() {
  # ~/.hermes/profiles/<name> for named profiles.
  echo "${HERMES_HOME:-$HOME/.hermes}/profiles/$1"
}

# Create a cron job only if no job with the same --name already exists.
cron_once() {
  local profile="$1" name="$2" schedule="$3" prompt="$4"; shift 4
  if hermes -p "$profile" cron list --all 2>/dev/null | grep -qiF "$name"; then
    echo "    · cron '$name' already present — skipping"
    return 0
  fi
  echo "    + cron '$name'  ($schedule)"
  hermes -p "$profile" cron create "$schedule" "$prompt" --name "$name" "$@"
}

echo "==> Installing solopreneur agent team from $PROFILES_DIR"
for p in "${PROFILE_NAMES[@]}"; do
  echo "  -> $p"
  hermes profile install "$PROFILES_DIR/$p" --name "$p" --alias --force -y

  # Seed the shared business registry into the profile's user-owned local/ dir
  # (distributions never overwrite local/, so your edits persist across updates).
  # chief-of-staff holds the ONE canonical copy; specialists symlink to it so
  # editing a single file updates the whole team (true single source of truth).
  dest="$(profile_home "$p")/local"
  mkdir -p "$dest"
  if [[ -e "$dest/businesses.yaml" || -L "$dest/businesses.yaml" ]]; then
    echo "    · local/businesses.yaml already present — leaving it untouched"
  elif [[ "$p" == "chief-of-staff" ]]; then
    cp "$REGISTRY_SRC" "$dest/businesses.yaml"
    echo "    · seeded canonical local/businesses.yaml (EDIT THIS ONE)"
  else
    # Relative symlink → ~/.hermes/profiles/chief-of-staff/local/businesses.yaml
    if ln -s "../../chief-of-staff/local/businesses.yaml" "$dest/businesses.yaml" 2>/dev/null; then
      echo "    · symlinked local/businesses.yaml → chief-of-staff canonical copy"
    else
      # Filesystems without symlink support (some Windows setups): fall back to a copy.
      cp "$REGISTRY_SRC" "$dest/businesses.yaml"
      echo "    · symlink unsupported — copied local/businesses.yaml (edit per profile)"
    fi
  fi

  # Vendor the bundled data skills the specialists' SOPs call. chief-of-staff
  # delegates (it reads the registry file directly), so it doesn't need them.
  if [[ "$p" != "chief-of-staff" ]]; then
    sdest="$(profile_home "$p")/skills"
    mkdir -p "$sdest"
    for s in "${DATA_SKILLS[@]}"; do
      if [[ -d "$sdest/$s" ]]; then
        :  # already present (installed or a prior run)
      elif [[ -f "$BUNDLED_SKILLS_SRC/$s/SKILL.md" ]]; then
        cp -R "$BUNDLED_SKILLS_SRC/$s" "$sdest/$s"
      else
        echo "    ! bundled skill '$s' not found at $BUNDLED_SKILLS_SRC — install it with 'hermes -p $p skills install $s'"
      fi
    done
    echo "    · vendored data skills: ${DATA_SKILLS[*]}"
  fi
done

if [[ "$WITH_CRON" == "1" ]]; then
  echo "==> Scheduling routines (delivery targets assume telegram/slack/email are configured)"

  echo "  -> chief-of-staff"
  cron_once chief-of-staff "Morning brief"          "30 7 * * *"  "Run the morning-brief skill: read local/businesses.yaml, pull what's due today across every active venture, delegate venture-specific digging to the specialist profiles, and deliver one prioritized brief." --deliver telegram --skill morning-brief --skill business-registry
  cron_once chief-of-staff "Weekly business review" "0 8 * * 1"   "Run the weekly-business-review skill: roll up last week across all ventures (content shipped, pipeline, cash, ops), flag what needs my decision this week." --deliver slack --skill weekly-business-review --skill business-registry

  echo "  -> content-marketer"
  cron_once content-marketer "Digest build"     "0 9 * * 4"   "Run the newsletter-digest skill for every venture whose content cadence is due (e.g. Launchly Digest). Produce a ready-to-send draft and queue it." --deliver slack --skill newsletter-digest
  cron_once content-marketer "Content queue check" "0 8 * * 1-5" "Run the content-calendar skill: check each content venture's calendar, surface gaps in the next 7 days, draft fillers." --deliver telegram --skill content-calendar

  echo "  -> sales-crm"
  cron_once sales-crm "Lead and outreach prep" "30 8 * * 1-5" "Run lead-research then outreach-sequence for ventures with the 'sales' operation: surface new leads and draft today's follow-ups." --deliver telegram --skill lead-research --skill outreach-sequence
  cron_once sales-crm "Pipeline review"        "0 16 * * 5"   "Run the pipeline-review skill across all sales ventures: stale deals, next actions, weekly movement." --deliver slack --skill pipeline-review

  echo "  -> finance-admin"
  cron_once finance-admin "Runway check" "0 7 * * *" "Run the runway-alert skill. If every venture is above its runway threshold and nothing is overdue, reply with exactly [SILENT]. Otherwise alert with specifics." --deliver telegram --skill runway-alert
  cron_once finance-admin "P&L digest"   "0 17 * * 5" "Run the pnl-digest skill: weekly revenue/expense summary per venture and combined." --deliver email --skill pnl-digest
  cron_once finance-admin "Invoice run"  "0 9 1 * *"  "Run the invoice-run skill: generate/queue this month's invoices per local/businesses.yaml finance settings and flag anything overdue." --deliver telegram --skill invoice-run

  echo "  -> ops-support"
  cron_once ops-support "Support triage" "0 */4 * * *" "Run the support-triage skill across all ops ventures. If there is nothing new or breaching SLA, reply with exactly [SILENT]. Otherwise summarize and propose responses." --deliver telegram --skill support-triage
  cron_once ops-support "KPI digest"     "0 9 * * 1"   "Run the kpi-digest skill: weekly operational KPIs per venture." --deliver slack --skill kpi-digest
else
  echo "==> Skipping cron (--no-cron)"
fi

# Resolve the Hermes home so the printed paths are correct even with a custom
# HERMES_HOME. ${HERMES_BASE} below is expanded; \$p / \$EDITOR stay literal.
HERMES_BASE="${HERMES_HOME:-$HOME/.hermes}"
cat <<NEXT

==============================================================================
 Team installed. Next steps:
==============================================================================
 1. Fill in API keys for each agent:
      for p in chief-of-staff content-marketer sales-crm finance-admin ops-support; do
        cp ${HERMES_BASE}/profiles/\$p/.env.EXAMPLE ${HERMES_BASE}/profiles/\$p/.env  # then edit
      done
 2. Edit the ONE canonical business registry (specialists symlink to it):
      \$EDITOR ${HERMES_BASE}/profiles/chief-of-staff/local/businesses.yaml
 3. Start the gateway so cron + delivery run:
      hermes gateway start
 4. Smoke-test one routine:
      hermes -p chief-of-staff cron list
      hermes -p chief-of-staff cron run <job_id>
 5. Chat with any agent directly (aliases were created with --alias):
      chief-of-staff chat
==============================================================================
NEXT
