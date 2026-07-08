# AGENTS

Follows `AGENT_BLUEPRINT.md` (version: 2026-03-28)

Irrelevant blueprint sections are intentionally omitted for this repo: autonomous GitHub Actions, design system, and decision artifacts. Everything else applies.

## Project Overview

Personal zsh configuration sourced from `~/.zshrc`. Environment setup plus small helpers (`tps`, `tpw`) that create detached tmux sessions for projects and git worktrees under `~/projects`, with zsh completion functions.

## Stack

- Zsh (macOS system zsh)
- tmux (target of the helpers; not a build dependency)
- No build system, no dependencies

## Environment

- Version manager: none (system zsh + tmux)
- Version file: n/a
- Lockfile: n/a
- Setup: add `source ~/.config/ohmyzsh/init.zsh` to `~/.zshrc` (see header of `init.zsh`)

## Commit Trailer Template

Store a template, not concrete runtime values.

```text
Co-authored-by: [AI_PRODUCT_NAME] <[AI_PRODUCT_EMAIL]>
AI-Provider: [AI_PROVIDER]
AI-Product: [AI_PRODUCT_LINE]
AI-Model: [AI_MODEL]
```

Template rules:
- `AI_PRODUCT_LINE` must be one of: `codex|claude|gemini|opencode`.
- Determine `AI_PROVIDER` and `AI_MODEL` from the most specific authoritative runtime metadata available (session metadata, then tool config, then UI labels).
- Resolve `AI_PRODUCT_NAME` and `AI_PRODUCT_EMAIL` from the model name using the tiered resolution in `AGENT_BLUEPRINT.md` `[BP-WF-COMMIT]`.
- Fill this template at commit time; do not persist filled values here.
- For multi-model commits, see `[BP-WF-COMMIT-MULTI]`.

## Validation Commands

| Level | Command | When |
|-------|---------|------|
| 1 | `zsh -n init.zsh` | After every change (syntax check) |
| 2 | Reasoned review of the diff | After code changes |
| 3 | Filesystem-only fixture tests (temp dirs, pure globs/string ops) | Before completing work |
| 4 | n/a (no UI) | — |

There is deliberately no live functional test level — see Project-Specific Rules.

## Execution Modes

### Shared Rules

- `roadmap/` is the canonical planning surface. Work unit IDs are 3-digit zero-padded.
- Keep changes minimal and scoped to the requested work unit.

### Runtime: Interactive Local

- Require user confirmation before `git commit`.
- Require user confirmation before installs or actions outside this repo.
- Stop for clarification when scope is ambiguous.

### Runtime: Autonomous Workflow

- Not configured for this repo. If ever added, follow `[BP-WF-AUTO]` in the blueprint.

## Never Run

- `tmux` commands, even with isolated `-L` test sockets — the user's live tmux server is on this machine; don't touch tmux at all.
- `killall` / the `killmedia` alias — suspends live macOS processes; edit its definition only.
- Never `source init.zsh` in a way that executes side effects against the live machine.

## Project-Specific Rules

- `init.zsh` is sourced by every new shell; a syntax error breaks shell startup. Always run `zsh -n` before finishing.
- Functional validation is filesystem-only: test globs/string logic against throwaway fixture trees in a scratchpad. The user smoke-tests live behavior (tmux, killall) themselves.
- Each helper function keeps a usage comment block above it — maintain that style.

## Knowledge Base

Tool: Roam Research

When asked to generate a Roam summary or thread:
- Parent block: `- [[<tool>]] [[<model-id>]] [[ai-thread]] [[ohmyzsh-config]]`
- Tool names: `claude-code` | `opencode` | `gemini-cli` | `codex-cli`
- Page refs: only include `[[Page Name]]` if explicitly instructed
- Sections: ask user what they want (chronological, functional, Q&A)

## Blueprint Updates

- Blueprint source of truth: [jgoodhcg/agent-blueprint](https://github.com/jgoodhcg/agent-blueprint), frontmatter `version` in `AGENT_BLUEPRINT.md` (date-based, `YYYY-MM-DD[.N]`).
- To upgrade: use the `blueprint-update` skill (`.claude/skills/blueprint-update/`), which fetches upstream, compares versions, and runs an alignment pass per `[BP-ALIGN]`.
- After upgrading, update the version reference at the top of this file.

## References

- For operating rules and report formats, see `AGENT_BLUEPRINT.md`.
- For planned/active work, see `roadmap/index.md`.

## Key Files

- `init.zsh` — all shell config and helpers (`tps`, `tpw`, completions)
- `README.md` — human-facing overview
- `.claude/skills/blueprint-update/SKILL.md` — blueprint upgrade + alignment skill

## User Profile (optional)

See `.agent-profile.md` (git-ignored) for interaction preferences. Not yet created — offer to create it on next alignment.
