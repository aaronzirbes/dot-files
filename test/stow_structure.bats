#!/usr/bin/env bats

# Test that the repo is structured correctly for GNU Stow

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

# --- Stow packages exist ---

@test "stow: zsh package has .zshenv" {
    [ -f "$DOTFILES_DIR/zsh/.zshenv" ]
}

@test "stow: zsh package has .zshrc" {
    [ -f "$DOTFILES_DIR/zsh/.zshrc" ]
}

@test "stow: git package has .gitconfig" {
    [ -f "$DOTFILES_DIR/git/.gitconfig" ]
}

@test "stow: git package has .gitignore_global" {
    [ -f "$DOTFILES_DIR/git/.gitignore_global" ]
}

@test "stow: git package has .gitflow_export" {
    [ -f "$DOTFILES_DIR/git/.gitflow_export" ]
}

@test "stow: tmux package has .tmux.conf" {
    [ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]
}

@test "stow: starship package has .config/starship.toml" {
    [ -f "$DOTFILES_DIR/starship/.config/starship.toml" ]
}

# --- Obsolete files are gone ---

@test "cleanup: .profile does not exist" {
    [ ! -f "$DOTFILES_DIR/.profile" ]
}

@test "cleanup: .bashrc does not exist" {
    [ ! -f "$DOTFILES_DIR/.bashrc" ]
}

@test "cleanup: git-prompt.sh does not exist" {
    [ ! -f "$DOTFILES_DIR/git-prompt.sh" ]
}

@test "cleanup: .hgrc does not exist" {
    [ ! -f "$DOTFILES_DIR/.hgrc" ]
}

@test "cleanup: groovy-grails.sh does not exist" {
    [ ! -f "$DOTFILES_DIR/groovy-grails.sh" ]
}

# --- Brewfile has required packages ---

@test "brewfile: includes stow" {
    grep -q 'brew "stow"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes starship" {
    grep -q 'brew "starship"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes eza" {
    grep -q 'brew "eza"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes zoxide" {
    grep -q 'brew "zoxide"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes git-delta" {
    grep -q 'brew "git-delta"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes mise" {
    grep -q 'brew "mise"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes zsh-syntax-highlighting" {
    grep -q 'brew "zsh-syntax-highlighting"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes zsh-autosuggestions" {
    grep -q 'brew "zsh-autosuggestions"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: includes bats-core" {
    grep -q 'brew "bats-core"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: does not include bash-git-prompt" {
    ! grep -q 'brew "bash-git-prompt"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: does not include bash-completion" {
    ! grep -q 'brew "bash-completion"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: does not include diff-so-fancy" {
    ! grep -q 'brew "diff-so-fancy"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: does not include autojump" {
    ! grep -q 'brew "autojump"' "$DOTFILES_DIR/Brewfile"
}

@test "brewfile: does not include tgt/brewhouse" {
    ! grep -q 'tgt/brewhouse' "$DOTFILES_DIR/Brewfile"
}
