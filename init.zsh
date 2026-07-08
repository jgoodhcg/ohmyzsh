# Custom Zsh init - sourced by .zshrc
# Add this to your ~/.zshrc:
# if [ -f ~/.config/ohmyzsh/init.zsh ]; then
#   source ~/.config/ohmyzsh/init.zsh
# fi

export EDITOR=nvim

# Kill macOS mediaanalysisd processes that peg the CPU.
# On this 2020 MacBook Pro (work machine, recently updated macOS),
# mediaanalysisd and mediaanalysisd-access consume excessive CPU
# and make the machine virtually unusable.
# SIGSTOP (-STOP) suspends them without terminating, so they don't
# just respawn immediately.
alias killmedia='killall -STOP mediaanalysisd mediaanalysisd-access'


# tps = "tmux project session"
# Usage: tps <project-name>
#
# What it does:
# 1. Looks for a first-level directory matching the name inside:
#      ~/projects/
#      ~/projects/games/
# 2. cd's into that directory
# 3. Creates a detached tmux session with the same name
# 4. Returns you to ~
#
# It does NOT attach. It only ensures the session exists.

tps() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "Usage: tps <project-name>"
    return 1
  fi

  local dir=""
  if [[ -d "$HOME/projects/$name" ]]; then
    dir="$HOME/projects/$name"
  elif [[ -d "$HOME/projects/games/$name" ]]; then
    dir="$HOME/projects/games/$name"
  else
    echo "Project not found in ~/projects or ~/projects/games"
    return 1
  fi

  cd "$dir" || return
  tmux new-session -d -s "$name" 2>/dev/null
  cd "$HOME"
}

_tps_completion() {
  local projects
  projects=(
    ${HOME}/projects/*(/:t)
    ${HOME}/projects/games/*(/:t)
  )
  compadd -- $projects
}

compdef _tps_completion tps


# tpw = "tmux project worktree"
# Usage: tpw <project> <worktree-label>
#
# What it does:
# 1. Discovers projects that have a .worktrees directory:
#      ~/projects/<project>.worktrees/
# 2. cd's into ~/projects/<project>.worktrees/<label>
# 3. Creates a detached tmux session named "<project>.<label>"
# 4. Returns you to ~
#
# It does NOT attach. It only ensures the session exists.

tpw() {
  local project="$1"
  local label="$2"

  if [[ -z "$project" || -z "$label" ]]; then
    echo "Usage: tpw <project> <worktree-label>"
    return 1
  fi

  local dir="$HOME/projects/$project.worktrees/$label"
  if [[ ! -d "$dir" ]]; then
    echo "Worktree not found: $dir"
    return 1
  fi

  cd "$dir" || return
  tmux new-session -d -s "$project.$label" 2>/dev/null
  cd "$HOME"
}

_tpw_completion() {
  local -a worktree_dirs projects
  worktree_dirs=(${HOME}/projects/*.worktrees(/:t))

  if (( CURRENT == 2 )); then
    # First arg: complete project names (strip .worktrees suffix)
    projects=(${worktree_dirs%.worktrees})
    compadd -- $projects
  elif (( CURRENT == 3 )); then
    # Second arg: complete worktree labels for the chosen project
    local project="$words[2]"
    local wt_dir="$HOME/projects/$project.worktrees"
    if [[ -d "$wt_dir" ]]; then
      compadd -- ${wt_dir}/*(/:t)
    fi
  fi
}

compdef _tpw_completion tpw
