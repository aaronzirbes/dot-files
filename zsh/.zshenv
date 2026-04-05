# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Path
export PATH="$HOME/bin:$PATH"

# Go
export GOPATH="$HOME/dev/go"
export PATH="$GOPATH/bin:$PATH"

# Git
export GITHUB_USERNAME='aaronzirbes'

# Editor
export EDITOR=nvim

# ctags
export CTAGS='-f ./.tags --exclude=.git --exclude=node_modules --exclude=build'

# Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_COLOR='1;31'

# Docker (Colima)
export DOCKER_IP=127.0.0.1
export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

# mise (version manager for node, python, ruby, java, etc.)
eval "$(mise activate zsh --shims)"
