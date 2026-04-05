Aaron Zirbes' dot files
=========================

Zsh, Git, Tmux, and Starship config for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

- **zsh** — Shell config with vi mode, history, completions, aliases
- **git** — Git config with delta diffs, aliases
- **tmux** — Tmux config with vim-style navigation
- **starship** — Cross-shell prompt config
- **scripts** — Helper scripts and utilities

Modern CLI tools: eza, bat, fzf, ripgrep, fd, zoxide, delta, mise

## Install

```bash
bash -c "$(curl -fsSkL raw.github.com/aaronzirbes/dot-files/main/go)"
```

This will:
1. Clone the repo to `~/.files/`
2. Install Homebrew packages from the Brewfile
3. Use `stow` to symlink configs into your home directory

## Manual stow usage

```bash
cd ~/.files
stow zsh git tmux starship scripts   # link everything
stow -D zsh                           # unlink a package
stow -R zsh                           # re-link (after changes)
```
