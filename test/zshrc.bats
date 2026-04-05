#!/usr/bin/env bats

# Test .zshrc interactive config
# Sources .zshenv + .zshrc in a zsh subshell

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

# Source both .zshenv and .zshrc, capturing a variable or alias
zshrc_eval() {
    zsh --no-rcs -c "
        source '$DOTFILES_DIR/zsh/.zshenv' 2>/dev/null
        source '$DOTFILES_DIR/zsh/.zshrc' 2>/dev/null
        $1
    " 2>/dev/null
}

# --- Aliases ---

@test "zshrc: alias ls points to eza" {
    result="$(zshrc_eval "alias ls")"
    [[ "$result" == *"eza"* ]]
}

@test "zshrc: alias ll points to eza -l" {
    result="$(zshrc_eval "alias ll")"
    [[ "$result" == *"eza -l"* ]]
}

@test "zshrc: alias cat points to bat" {
    result="$(zshrc_eval "alias cat")"
    [[ "$result" == *"bat"* ]]
}

@test "zshrc: alias top points to htop" {
    result="$(zshrc_eval "alias top")"
    [[ "$result" == *"htop"* ]]
}

@test "zshrc: alias nv points to nvim" {
    result="$(zshrc_eval "alias nv")"
    [[ "$result" == *"nvim"* ]]
}

@test "zshrc: alias mast uses main (not master)" {
    result="$(zshrc_eval "alias mast")"
    [[ "$result" == *"main"* ]]
    [[ "$result" != *"master"* ]]
}

# --- Functions ---

@test "zshrc: function pods is defined" {
    result="$(zshrc_eval "whence -w pods")"
    [[ "$result" == *"function"* ]]
}

@test "zshrc: function g-findword is defined" {
    result="$(zshrc_eval "whence -w g-findword")"
    [[ "$result" == *"function"* ]]
}

@test "zshrc: function j-findword is defined" {
    result="$(zshrc_eval "whence -w j-findword")"
    [[ "$result" == *"function"* ]]
}

@test "zshrc: function promptEmoji is defined" {
    result="$(zshrc_eval "whence -w promptEmoji")"
    [[ "$result" == *"function"* ]]
}

@test "zshrc: promptEmoji returns an emoji" {
    result="$(zshrc_eval "promptEmoji")"
    [ -n "$result" ]
}

# --- History ---

@test "zshrc: HISTSIZE is 50000" {
    result="$(zshrc_eval "echo \$HISTSIZE")"
    [ "$result" = "50000" ]
}

@test "zshrc: SAVEHIST is 50000" {
    result="$(zshrc_eval "echo \$SAVEHIST")"
    [ "$result" = "50000" ]
}

# --- Vi mode ---

@test "zshrc: KEYTIMEOUT is 1 (fast vi mode switch)" {
    result="$(zshrc_eval "echo \$KEYTIMEOUT")"
    [ "$result" = "1" ]
}
