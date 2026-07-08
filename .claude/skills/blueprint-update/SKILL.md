---
name: blueprint-update
description: Update AGENT_BLUEPRINT.md from upstream jgoodhcg/agent-blueprint and run an alignment pass. Use when the user asks to update, upgrade, or re-align the agent blueprint.
---

# Blueprint Update

Upgrade this repo's `AGENT_BLUEPRINT.md` to the latest upstream version and re-align.

## Steps

1. Fetch the upstream blueprint:
   ```
   curl -sL https://raw.githubusercontent.com/jgoodhcg/agent-blueprint/main/AGENT_BLUEPRINT.md
   ```
2. Compare the frontmatter `version` (date-based `YYYY-MM-DD[.N]`) against the local `AGENT_BLUEPRINT.md`. If upstream is not newer, report that and stop.
3. Replace the local `AGENT_BLUEPRINT.md` with the upstream copy.
4. Run an alignment pass per `[BP-ALIGN]` in the blueprint:
   - Compare `AGENTS.md` and `roadmap/` against the new blueprint.
   - Skip sections this repo intentionally omits (listed at the top of `AGENTS.md`): autonomous GitHub Actions, design system, decision artifacts.
   - Report gaps using the `[BP-ALIGN-REPORT]` format, propose a minimal patch plan, apply focused edits.
5. Update the version reference at the top of `AGENTS.md` to the new blueprint version.
6. Validate: `zsh -n init.zsh` if `init.zsh` changed (it normally shouldn't).
7. Present proposed changes and commit message; commit only after user approval, with trailers per the template in `AGENTS.md`.

## Constraints

- Respect `AGENTS.md` Never Run rules (no tmux, no killall) during any validation.
- Keep edits minimal; alignment is not an invitation to refactor.
