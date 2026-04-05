#!/usr/bin/env bats

# Test .zshenv environment variables and PATH setup
# Runs zsh non-interactively to source .zshenv

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

zshenv_var() {
    zsh -c "ZDOTDIR='$DOTFILES_DIR/test/fake_home' source '$DOTFILES_DIR/zsh/.zshenv' 2>/dev/null; echo \"\$$1\""
}

@test "zshenv: EDITOR is set to nvim" {
    result="$(zshenv_var EDITOR)"
    [ "$result" = "nvim" ]
}

@test "zshenv: GITHUB_USERNAME is set" {
    result="$(zshenv_var GITHUB_USERNAME)"
    [ "$result" = "aaronzirbes" ]
}

@test "zshenv: GOPATH is set" {
    result="$(zshenv_var GOPATH)"
    [ "$result" = "$HOME/dev/go" ]
}

@test "zshenv: CLICOLOR is enabled" {
    result="$(zshenv_var CLICOLOR)"
    [ "$result" = "1" ]
}

@test "zshenv: DOCKER_IP is set" {
    result="$(zshenv_var DOCKER_IP)"
    [ "$result" = "127.0.0.1" ]
}

@test "zshenv: DOCKER_HOST uses colima socket" {
    result="$(zshenv_var DOCKER_HOST)"
    [[ "$result" == *"colima"* ]]
}

@test "zshenv: GREP_COLOR is set" {
    result="$(zshenv_var GREP_COLOR)"
    [ "$result" = "1;31" ]
}

@test "zshenv: PATH contains ~/bin" {
    result="$(zsh -c "source '$DOTFILES_DIR/zsh/.zshenv' 2>/dev/null; echo \"\$PATH\"")"
    [[ "$result" == *"$HOME/bin"* ]]
}

@test "zshenv: PATH contains GOPATH/bin" {
    result="$(zsh -c "source '$DOTFILES_DIR/zsh/.zshenv' 2>/dev/null; echo \"\$PATH\"")"
    [[ "$result" == *"dev/go/bin"* ]]
}

@test "zshenv: PATH contains homebrew" {
    result="$(zsh -c "source '$DOTFILES_DIR/zsh/.zshenv' 2>/dev/null; echo \"\$PATH\"")"
    [[ "$result" == *"/opt/homebrew/bin"* ]]
}

@test "zshenv: deprecated GREP_OPTIONS is not set" {
    result="$(zshenv_var GREP_OPTIONS)"
    [ -z "$result" ]
}

@test "zshenv: BASH_SILENCE_DEPRECATION_WARNING is not set" {
    result="$(zshenv_var BASH_SILENCE_DEPRECATION_WARNING)"
    [ -z "$result" ]
}
