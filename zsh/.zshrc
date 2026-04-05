# Zsh options
bindkey -v
export KEYTIMEOUT=1

setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Completions (FPATH must come before compinit)
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# Aliases
alias ls='eza'
alias ll='eza -l'
alias tree='eza --tree'
alias cat='bat'
alias top='htop'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias nv=nvim
alias vimrc='nv ~/.vim/vimrc'
alias ghb='gh browse'
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias getopt="$(brew --prefix gnu-getopt)/bin/getopt"
alias format="gradle spotlessApply"
alias grc='gradle --continuous'
alias docker-start='colima start'
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias pyserve='python -m http.server'
alias mast='git co main'

# Functions
function pods() {
    on=$'\e[1;49;37m'
    green=$'\e[1;49;32m'
    red=$'\e[1;49;31m'
    yellow=$'\e[1;49;33m'
    off=$'\e[m'
    kubectl get pods | \
    sed -e "s/[[:blank:]]\([0-9]*[1-9][0-9]*\)[[:blank:]]/ $red\1$off /g" \
    -e "s/\(ContainerCreating\)/$yellow\1$off/g" \
    -e "s/\(Running\)/$green\1$off/g" \
    -e "s/\(Terminating\)/$red\1$off/g" \
    -e "s/\(CrashLoopBackOff\)/$red\1$off/g" \
    -e "s/\(Error\)/$red\1$off/g" \
    -e "s/\(0\/1\)/$red\1$off/g" \
    -e "s/[[:blank:]]\([0-9][0-9]*s\)/ $red\1$off /g" \
    -e "s/[[:blank:]]\([0-9][0-9]*m\)/ $yellow\1$off /g" \
    -e "s/[[:blank:]]\([0-9][0-9]*h\)/ $green\1$off /g" \
    -e "s/[[:blank:]]\([0-9][0-9]*d\)/ $green\1$off /g"
}

function g-findword() {
    grep --include '*.java' --include '*.groovy' --include '*.gsp' --include '*.gradle' -rE "\<${1}\>" .
}

function j-findword() {
    grep --include '*.js' --include '*.html' --include '*.css' -rE "\<${1}\>" .
}

function promptEmoji() {
    export simple_arrow='→'
    export simple_fail='!'
    export fancy_arrow='➦'
    export fancy_fail='✘'
    export beer='🍺 '
    export shamrock='☘️ '
    export wine='🍷 '
    export coffee='☕ '
    export cat='😺 '
    export lamp='🪔 '
    export leaves_fall='🍂 '
    export jack_o_lantern='🎃 '
    export move_right='\e[1C'
    export snowflake='❄️ '

    now_hour=$(date +%H | sed -e 's/^0//')

    if (( $now_hour < 16 )); then
        echo -n $coffee
    else
        echo -n $shamrock
    fi
}

function useZirbesAwsCreds() {
    if [ -r $HOME/dev/zirbes.awscreds ]; then
        echo "Using aaronzirbes AWS Creds"
        source $HOME/dev/zirbes.awscreds
    fi
}

function configureAwsCreds() {
    useZirbesAwsCreds
    export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.5.3/libexec"
    export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"
}

# Source helper scripts
[ -f ~/.files/vim_dev.sh ] && source ~/.files/vim_dev.sh
[ -s ~/bin/.local_profile ] && source ~/bin/.local_profile

# Tool initializations

# mise (replaces nvm, pyenv, jenv, sdkman, chruby)
eval "$(mise activate zsh)"

# SSH agent
eval "$(ssh-agent -s)" &>/dev/null

# fzf
source <(fzf --zsh)

# zoxide (replaces autojump)
eval "$(zoxide init zsh)"

# iTerm2 shell integration
[ -e "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# Plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt (must be last)
eval "$(starship init zsh)"
