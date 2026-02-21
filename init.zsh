# Custom Zsh init - sourced by .zshrc
# Add this line to your ~/.zshrc:
# source ~/.config/ohmyzsh/init.zsh

export EDITOR=nvim


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
