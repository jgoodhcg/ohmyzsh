# ohmyzsh

Custom zsh shell extensions. Sourced via `~/.zshrc`.

## Setup

Add this to your `~/.zshrc`:

```zsh
if [ -f ~/.config/ohmyzsh/init.zsh ]; then
  source ~/.config/ohmyzsh/init.zsh
fi
```

## Commands

### `tps` — tmux project session

Spins up a detached tmux session rooted in a project directory. Tab-completable.

```
tps <project>
```

Looks for `~/projects/<project>` or `~/projects/games/<project>`, creates a tmux session named after the project.

### `tpw` — tmux project worktree

Same idea, but for git worktrees. Tab-completable at both the project and worktree level.

```
tpw <project> <worktree-label>
```

Looks for `~/projects/<project>.worktrees/<label>`, creates a tmux session named `<project>.<label>`.

Any project with a `<name>.worktrees/` directory in `~/projects/` is auto-discovered.

## Expected directory layout

```
~/projects/
  myapp/                    # regular project  (tps myapp)
  games/
    tetris/                 # nested project   (tps tetris)
  myapp.worktrees/
    bug-fix/                # worktree         (tpw myapp bug-fix)
    feature-x/              # worktree         (tpw myapp feature-x)
```
