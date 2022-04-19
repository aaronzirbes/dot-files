# Git Vars
export GITHUB_USERNAME='aaronzirbes'

# Add homebrew to path
export PATH="/usr/local/bin::$PATH"
# Add my bin folder to path
export PATH="$HOME/bin:/usr/local/sbin:$PATH"
# Adding ruby gems to path
export PATH="/usr/local/Cellar/ruby/1.9.3-p362/bin:$PATH"
#o Adding NPM to path
export PATH="/usr/local/share/npm/bin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
### Added by Pyhon pipenv
export PATH="$HOME/Library/Python/3.6/bin:$PATH"

# ctags
export CTAGS='-f ./.tags --exclude=.git --exclude=node_modules --exclude=build'
 
# grep colors
export GREP_COLOR='1;31'
export GREP_OPTIONS='--color=auto'

# LS Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Consul
#export CONSUL_HOST='localhost'
#export CONSUL_PORT='8500'
#export CONSUL_URI='http://localhost:8500'
#export VAULT_URI='http://localhost:8200'
#export VAULT_TOKEN='default-token'

# From brew install mono
export MONO_GAC_PREFIX="/usr/local"

. $HOME/.files/vim_dev.sh

#export JAVA_HOME="${HOME}/.sdkman/candidates/java/current"

# JDK 8
# export JAVA_OPTS='-Djava.awt.headless=true -Xms1536m -Xmx1536m -XX:+UseConcMarkSweepGC'
# export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home/'

# JDK 9
# export JAVA_OPTS='-Djava.awt.headless=true -Xms1536m -Xmx1536m'
# export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home/'

# JDK11
# export JAVA_OPTS='-Djava.awt.headless=true -Xms2G -Xmx2G'
# export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk-11+28/Contents/Home/'

launchctl setenv JAVA_HOME "${JAVA_HOME}"

export GOPATH="$HOME/dev/go"
# Add Golang to path
export PATH="$GOPATH/bin:$PATH"

alias ll='ls -l'
alias getopt="$(brew --prefix gnu-getopt)/bin/getopt"
alias ghb='gh browse'
alias nv=nvim
alias gremlin='~/dse/bin/dse gremlin-console'
alias ubuntu='docker run -i -t ubuntu:14.04 bash'
alias uuid="uuidgen |tr '[:upper:]' '[:lower:]'"

alias vimrc='nv ~/.vim/vimrc'
alias docker-start='colima start'
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias grc='gradle --continuous'
alias cat='bat'
alias top='htop'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias pyserve='python -m http.server'
alias mast='git co master'

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


function configurePrompt() {
    export simple_arrow='→'
    export simple_fail='!'
    export fancy_arrow='➦'
    export fancy_fail='✘'
    export beer='🍺 '
    export wine='🍷 '
    export coffee='☕ '
    export cat='😺 '
    export move_right='\e[1C'

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
        #GIT_PROMPT_THEME=Default
        GIT_PROMPT_THEME=Solarized
        # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
        if [ "$VIMRUNTIME" != "" ]; then
            # Neo vim has an odd alignment issue in the terminal emulator for the beer/wine/coffee character
            GIT_PROMPT_END='\e[1;34m `date`\e[0m\n\e[1;32mVim $\e[0m '
        else
            GIT_PROMPT_END='\e[1;34m `date`\e[0m\n${cat} '
        fi

       # as last entry source the gitprompt script
       # GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
       # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme

        source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
    fi

    # Seeing: "sed: RE error: illegal byte sequence" here...
    source "$(brew --prefix bash-completion)/etc/bash_completion"

}
configurePrompt

function configureDockerOld() {
    export DOCKER_TLS_VERIFY=1
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=${HOME}/.boot2docker/certs/boot2docker-vm
}


export DOCKER_IP=127.0.0.1

function useZirbesAwsCreds() {
    if [ -r $HOME/dev/zirbes.awscreds ]; then
        echo "Using aaronzirbes AWS Creds"
        source $HOME/dev/zirbes.awscreds
    fi
}

function configureAwsCreds() {
    # Source AWS Creds
    useZirbesAwsCreds
    export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.5.3/libexec"
    export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"
}


export ANDROID_SDK_HOME="${HOME}/dev/android/sdk/24.3.3/android-sdk-macosx"

set -o vi

# Java Environment manager
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
#jenv global 1.8

# Installed SDK Man via:
#     curl -s get.sdkman.io | bash

# Sourcing chruby
#. /usr/local/share/chruby/chruby.sh
# Using ruby 2.2.3
#chruby ruby-2.2.3

# Source Target stuffs
. $HOME/bin/tgt_vars

export ANDROID_HOME=/usr/local/share/android-sdk

export BASH_SILENCE_DEPRECATION_WARNING=1
export TMPDIR=`mktemp -d -t ajztemp`
chown -R `whoami` $TMPDIR
launchctl setenv TMPDIR "${TMPDIR}"

# Python
#export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
#export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

eval "$(ssh-agent -s)" >> /dev/null
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[ -s "${HOME}/bin/.local_profile" ] && source "${HOME}/bin/.local_profile"
[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
[ -e "${HOME}/.iterm2_shell_integration.bash" ] && source "${HOME}/.iterm2_shell_integration.bash"
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
[ -e /usr/local/share/git-fuzzy ] && export PATH="/usr/local/share/git-fuzzy/bin:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
