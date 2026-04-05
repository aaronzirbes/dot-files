#!/usr/bin/env bats

# Test starship.toml configuration

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
STARSHIP_CONFIG="$DOTFILES_DIR/starship/.config/starship.toml"

@test "starship: config is valid toml (starship validates)" {
    command -v starship &>/dev/null || skip "starship not installed"
    STARSHIP_CONFIG="$STARSHIP_CONFIG" run starship config
    [ "$status" -eq 0 ]
}

@test "starship: time module is enabled" {
    grep -q 'disabled = false' "$STARSHIP_CONFIG"
}

@test "starship: git_branch module is configured" {
    grep -q '\[git_branch\]' "$STARSHIP_CONFIG"
}

@test "starship: git_status module is configured" {
    grep -q '\[git_status\]' "$STARSHIP_CONFIG"
}

@test "starship: character module is configured" {
    grep -q '\[character\]' "$STARSHIP_CONFIG"
}
