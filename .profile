# Git Vars
export GITHUB_USERNAME='aaronzirbes'

# Add homebrew to path
export PATH="/usr/local/bin::$PATH"
# Add my bin folder to path
export PATH="$HOME/bin:/usr/local/sbin:$PATH"
# Adding ruby gems to path
export PATH="/usr/local/Cellar/ruby/1.9.3-p362/bin:$PATH"
# Adding NPM to path
export PATH="/usr/local/share/npm/bin:$PATH"
# Adding Yarn to path
export PATH="$PATH:`yarn global bin`"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# export PORTAL_E2E_USER="connectedfleetautomation-ug+admin@peoplenetonline.com"
# export PORTAL_E2E_PASS="Password1"

export PORTAL_E2E_USER="azirbes@peoplenetonline.com"
export PORTAL_E2E_PASS="Z?VJTLM9o[7fTev3thd"

# ctags
export CTAGS='-f ./.tags --exclude=.git --exclude=node_modules --exclude=build'
 
# grep colors
export GREP_COLOR='1;31'
export GREP_OPTIONS='--color=auto'

# LS Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. $HOME/.files/vim_dev.sh

export JAVA_OPTS='-Djava.awt.headless=true -Xms1536m -Xmx1536m -XX:+UseConcMarkSweepGC'
export JAVA_HOME="${HOME}/.sdkman/candidates/java/current"
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/'

export GOPATH="$HOME/dev/go"
# Add Golang to path
export PATH="$GOPATH/bin:$PATH"

alias ll='ls -l'
alias getopt="$(brew --prefix gnu-getopt)/bin/getopt"
alias gh='hub browse'
alias nv=nvim
alias gremlin='~/dse/bin/dse gremlin-console'
alias ubuntu='docker run -i -t ubuntu:14.04 bash'
alias uuid='groovy -e "println UUID.randomUUID()"'
alias kc=kubectl
alias updatepass='gopass git --store wms pull'

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
    export move_right='\e[1C'

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
        #GIT_PROMPT_THEME=Default
        GIT_PROMPT_THEME=Solarized
        # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
        if [ "$VIMRUNTIME" != "" ]; then
            # Neo vim has an odd alignment issue in the terminal emulator for the beer character
            GIT_PROMPT_END='\e[1;34m `date`\e[0m\n\e[1;32mVim $\e[0m '
        else
            GIT_PROMPT_END='\e[1;34m `date`\e[0m\n${beer} '
        fi

       # as last entry source the gitprompt script
       # GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
       # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme

        source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
    fi

    # [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
    source "$(brew --prefix bash-completion)/etc/bash_completion"

    __git_complete kc kubectl
}
configurePrompt

function configureDockerOld() {
    export DOCKER_TLS_VERIFY=1
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=${HOME}/.boot2docker/certs/boot2docker-vm
}

function configureDocker() {
    eval "$(/usr/local/bin/docker-machine env dev)"
}

# configureDocker
export DOCKER_IP=127.0.0.1

alias pyserve='python -m SimpleHTTPServer'

function useZirbesAwsCreds() {
    echo "Using aaronzirbes AWS Creds"
    if [ -r $HOME/dev/zirbes.awscreds ]; then
        . $HOME/dev/zirbes.awscreds
    fi
}

function configureAwsCreds() {
    # Source AWS Creds
    useZirbesAwsCreds
    export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.5.3/libexec"
    export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"
}

configureAwsCreds

if [ -d /usr/local/kafka/kafka_2.11-0.8.2.0/bin ]; then
    export PATH="${PATH}:/usr/local/kafka/kafka_2.11-0.8.2.0/bin"
fi

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

export ANDROID_HOME=/usr/local/share/android-sdk
# Source drone configuration
. ~/ole/.drone_config

eval "$(ssh-agent -s)"
export EDITOR=nvim

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
[ -e "${HOME}/.iterm2_shell_integration.bash" ] && . "${HOME}/.iterm2_shell_integration.bash"

