---
title: "Support nested worktree paths in tpw"
status: done
description: "Handle slashed branch names (feat/13396-e-sig) in tpw lookup, session naming, and completion"
created: 2026-07-08
updated: 2026-07-08
tags: [tmux, worktrees, completion]
priority: medium
---

# Support nested worktree paths in tpw

## Intent

GitKraken (and git itself) create worktrees for branches with `/` in the name as nested subdirectories, e.g. `kyber.worktrees/feat/13396-e-sig`. `tpw` completion only listed first-level directories, so nested worktrees were invisible.

## Specification

- `tpw <project> <label>` accepts labels containing slashes (lookup already worked; it is plain path joining).
- Session name flattens `/` to `-` (`kyber.feat-13396-e-sig`) to avoid colliding with tmux target syntax.
- Completion discovers worktrees as directories containing a `.git` entry, probing up to 3 levels deep (bounded, so tab-complete never walks `node_modules`).
- README documents slashed labels and the nested layout.

## Validation

- [x] `zsh -n init.zsh` passes
- [x] Completion glob tested against fixture tree: returns `bug-fix`, `feat/13396-e-sig`, `feat/9999-other`; skips intermediate `feat/` dir
- [x] Slash-to-dash substitution verified (`kyber.feat-13396-e-sig`)
- [x] User smoke-tested live: "It's working great"

## Scope

No changes to `tps`. No tmux-side migration of existing session names.

## Context

- `init.zsh` — `tpw()` and `_tpw_completion()`
- tmux rewrites `.`/`:` in session names itself; slashes are flattened by us for readability and target-syntax safety.
