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
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# ctags
export CTAGS='-f ./.tags' 
 
# grep colors
export GREP_COLOR='1;31'
export GREP_OPTIONS='--color=auto'

# LS Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. $HOME/lib/dot-files/vim_dev.sh

export JAVA_OPTS='-Djava.awt.headless=true -Xms1536m -Xmx1536m -XX:+UseConcMarkSweepGC'

export GOPATH="$HOME/dev/go"
# Add Golang to path
export PATH="$GOPATH/bin:$PATH"

alias ll='ls -l'
alias getopt="$(brew --prefix gnu-getopt)/bin/getopt"
alias gh='hub browse'
alias nv=nvim
alias gremlin='~/dse/bin/dse gremlin-console'

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

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
        #GIT_PROMPT_THEME=Default
        GIT_PROMPT_THEME=Solarized
        # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
        GIT_PROMPT_END='\e[1;34m `date`\e[0m\n${beer} '

       # as last entry source the gitprompt script
       # GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
       # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme

        source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
    fi

    source "$(brew --prefix bash-completion)/etc/bash_completion"
}
configurePrompt

function configureDockerOld() {
    export DOCKER_TLS_VERIFY=1
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/ajz/.boot2docker/certs/boot2docker-vm
}

function configureDocker() {
    eval "$(/usr/local/bin/docker-machine env dev)"
}

# configureDocker

alias pyserve='python -m SimpleHTTPServer'

function usePeopleNetAwsCreds() {
    echo "Using PeopleNet AWS Creds"
    if [ -r $HOME/dev/peoplenet/pnetaws.awscreds ]; then
        . $HOME/dev/peoplenet/pnetaws.awscreds
    fi
}

function useZirbesAwsCreds() {
    echo "Using aaronzirbes AWS Creds"
    if [ -r $HOME/dev/zirbes.awscreds ]; then
        . $HOME/dev/zirbes.awscreds
    fi
}

function configureAwsCreds() {
    # Source AWS Creds
    if (ifconfig jnc0 > /dev/null 2> /dev/null ); then
        usePeopleNetAwsCreds
    else
        en0_ip=`ifconfig en0 inet |grep inet |cut -f 2 -d ' '`
        en0_gw=`ifconfig en0 inet |grep inet |cut -f 6 -d ' '`
        if [[ "${en0_ip}" =~ "10.10." ]] && [ "${en0_gw}" == "10.10.47.255" ]; then
            # We are at PeopleNet (prolly)
            usePeopleNetAwsCreds

        else
            useZirbesAwsCreds
        fi

    fi
    export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.5.3/libexec"
    export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"
}

#usePeopleNetAwsCreds
configureAwsCreds

if [ -d /usr/local/kafka/kafka_2.11-0.8.2.0/bin ]; then
    export PATH="${PATH}:/usr/local/kafka/kafka_2.11-0.8.2.0/bin"
fi

export ANDROID_SDK_HOME="/Users/ajz/dev/android/sdk/24.3.3/android-sdk-macosx"

set -o vi

# Java Environment manager
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
#jenv global 1.8

# Installed SDK Man via:
#     curl -s get.sdkman.io | bash


# Sourcing chruby
. /usr/local/share/chruby/chruby.sh

# Using ruby 2.2.3
chruby ruby-2.2.3

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ajz/.sdkman"
[[ -s "/Users/ajz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ajz/.sdkman/bin/sdkman-init.sh"
