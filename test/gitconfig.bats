#!/usr/bin/env bats

# Test .gitconfig settings

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
GITCONFIG="$DOTFILES_DIR/git/.gitconfig"

git_config() {
    git config --file "$GITCONFIG" "$1"
}

@test "gitconfig: user name is set" {
    result="$(git_config user.name)"
    [ "$result" = "Aaron J. Zirbes" ]
}

@test "gitconfig: user email is set" {
    result="$(git_config user.email)"
    [ "$result" = "aaron.zirbes@gmail.com" ]
}

@test "gitconfig: excludesfile uses portable path" {
    result="$(git_config core.excludesfile)"
    [ "$result" = "~/.gitignore_global" ]
    [[ "$result" != *"/Users/"* ]]
}

@test "gitconfig: pager uses delta (not diff-so-fancy)" {
    result="$(git_config pager.diff)"
    [ "$result" = "delta" ]
}

@test "gitconfig: delta side-by-side is enabled" {
    result="$(git_config delta.side-by-side)"
    [ "$result" = "true" ]
}

@test "gitconfig: interactive diffFilter uses delta" {
    result="$(git_config interactive.diffFilter)"
    [[ "$result" == *"delta"* ]]
}

@test "gitconfig: pull.rebase is true" {
    result="$(git_config pull.rebase)"
    [ "$result" = "true" ]
}

@test "gitconfig: push default is simple" {
    result="$(git_config push.default)"
    [ "$result" = "simple" ]
}

@test "gitconfig: alias 'co' is checkout" {
    result="$(git_config alias.co)"
    [ "$result" = "checkout" ]
}

@test "gitconfig: alias 'cm' is checkout main" {
    result="$(git_config alias.cm)"
    [ "$result" = "checkout main" ]
}

@test "gitconfig: no Target hub host configured" {
    run git_config hub.host
    [ "$status" -ne 0 ]
}
