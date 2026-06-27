# CLAUDE.md

This file gives Claude Code the essentials for working in this repo. The
canonical, fuller development guide is **AGENTS.md** — read it for
architecture, the contribution rubric, and design constraints (especially the
prompt-caching rules in the core agent loop). This file only adds what's
specific to Claude Code sessions.

## Setup

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
cd "${HERMES_HOME:-$HOME/.hermes}/hermes-agent"
uv pip install -e ".[all,dev]"   # dev/test extras
```

Manual clone fallback (e.g. throwaway container/CI checkout — this repo):

```bash
uv venv venv --python 3.11
export VIRTUAL_ENV="$(pwd)/venv"
uv pip install -e ".[all,dev]"
```

Run `hermes` from the venv that owns this checkout, not a system Python —
mixing venvs is the most common cause of "missing module" support requests.

## Common commands

```bash
scripts/run_tests.sh        # preferred — matches CI (hermetic env, 4 xdist workers)
pytest tests/ -v             # alternative, after activating the venv
hermes doctor                # diagnose config/dependency issues
hermes chat -q "Hello"        # quick manual smoke test
hermes -z "Hello"            # one-shot, no banner/spinner — good for scripted checks
```

## MCP integration in this repo

`.mcp.json` at the repo root registers project-scoped MCP servers for Claude
Code (loaded automatically, with an approval prompt on first use — see
Anthropic's [MCP docs](https://docs.claude.com/en/docs/claude-code/mcp)).
Currently registered:

- `agentskills` — `https://agentskills.io/mcp` (HTTP transport), exposing
  `search_agent_skills` and `query_docs_filesystem_agent_skills` for browsing
  the [agentskills.io](https://agentskills.io) Agent Skills marketplace.

Hermes itself can also run as an MCP server (`hermes mcp serve`, stdio
transport) so other agents — including Claude Code — can drive a Hermes
conversation as a tool. To register Hermes as an MCP server for Claude Code,
point a stdio entry at the `hermes` binary from the venv you installed into:

```json
{
  "mcpServers": {
    "hermes": {
      "command": "/path/to/venv/bin/hermes",
      "args": ["mcp", "serve"]
    }
  }
}
```

`hermes` itself consumes MCP servers the same way — `hermes mcp add <name>
--url <endpoint>` or `--command <cmd> --args ...`, then `hermes mcp list` /
`hermes mcp configure` to manage them. See `mcp_serve.py` for the server-side
implementation.

## Gotchas

- Per-conversation prompt caching is load-bearing for cost — see AGENTS.md
  before touching anything in the core agent loop that rebuilds the system
  prompt or swaps toolsets mid-conversation.
- `hermes` provider auth differs by provider: most use static API keys
  (`hermes auth add <provider> --type api-key`), but `nous` (Nous Portal) is
  registered as `oauth_device_code` only — an api-key credential added for
  `nous` is stored in the credential pool but is **not** read by the chat
  runtime (`resolve_nous_runtime_credentials` in `hermes_cli/auth.py`), which
  requires the OAuth device-code login state under `providers.nous`. Run
  `hermes auth add nous --type oauth` (or `hermes portal`) to actually use
  Nous as a chat provider; a raw `sk-nous-...` key only works for direct API
  calls to `inference-api.nousresearch.com`.
