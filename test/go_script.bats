#!/usr/bin/env bats

# Test the go bootstrap script

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

# --- linkScripts function ---

@test "go: ct script exists and is executable" {
    [ -x "$DOTFILES_DIR/ct" ]
}

@test "go: linkScripts creates symlink to ct" {
    local tmphome
    tmphome="$(mktemp -d)"
    HOME="$tmphome" DOTFILES_DIR="$DOTFILES_DIR" bash -c '
        eval "$(sed -n "/^function linkScripts/,/^}/p" "'"$DOTFILES_DIR"'/go")"
        linkScripts
    '
    [ -L "$tmphome/.local/bin/ct" ]
    [ "$(readlink "$tmphome/.local/bin/ct")" = "$DOTFILES_DIR/ct" ]
    rm -rf "$tmphome"
}

@test "go: linkScripts is idempotent" {
    local tmphome
    tmphome="$(mktemp -d)"
    HOME="$tmphome" DOTFILES_DIR="$DOTFILES_DIR" bash -c '
        eval "$(sed -n "/^function linkScripts/,/^}/p" "'"$DOTFILES_DIR"'/go")"
        linkScripts
        linkScripts
    '
    [ -L "$tmphome/.local/bin/ct" ]
    rm -rf "$tmphome"
}
