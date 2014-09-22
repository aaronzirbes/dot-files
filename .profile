# Bloom Vars
export GITHUB_USERNAME='aaronzirbes'
export BLOOM_GIT_SANDBOX="$HOME/dev/grails/bloom"

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH"
# Adding ruby gems to path
export PATH="/usr/local/Cellar/ruby/1.9.3-p362/bin:/usr/local/share/npm/bin:$PATH"

. $BLOOM_GIT_SANDBOX/dev_scripts/bash/bitbucket-sandbox.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/bloom-logo.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/bloom-plugins.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/ctags.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/grep-colors.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/groovy-grails.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/java-home.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/ls-colors.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/mysql.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/rabbitmq.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/markdown.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/vim_dev.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/prompt.sh
. $BLOOM_GIT_SANDBOX/dev_scripts/bash/vagrant.sh

export GRAILS_OPTS="-Xms2g -Xmx2g -XX:PermSize=128m -XX:MaxPermSize=512m -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -server"
export GRADLE_OPTS='-Dorg.gradle.daemon=true -Djava.awt.headless=true'
#export JAVA_OPTS='-Xms1G -Xmx1G -XX:MaxPermSize=512m -XX:+UseConcMarkSweepGC'
#export JAVA_OPTS='-Djava.awt.headless=true -Xms1G -Xmx1G -XX:MaxPermSize=512m -XX:+UseConcMarkSweepGC'
export JAVA_OPTS='-Djava.awt.headless=true -Xms1536m -Xmx1536m -XX:MaxPermSize=768m -XX:+UseConcMarkSweepGC'

export GOPATH="$HOME/dev/go"

. ~/lib/git-prompt.sh

function bloom-update-plugins() {
    pushd ~/bc > /dev/null
    current_branch=`git branch --no-color | grep -E '^\* ' |sed -e 's/^\* //'`
    git pull origin ${current_branch} && grails --non-interactive clean && grails --non-interactive compile && grails maven-install
    popd > /dev/null

    pushd ~/bd > /dev/null
    current_branch=`git branch --no-color | grep -E '^\* ' |sed -e 's/^\* //'`
    git pull origin ${current_branch} && grails --non-interactive clean && grails --non-interactive compile && grails maven-install
    popd > /dev/null
}

alias ll='ls -l'
alias getopt="$(brew --prefix gnu-getopt)/bin/getopt"
alias g-mi="gradle publishMavenJavaPublicationToMavenLocal -Psnapshot=true"

function git-fa() {
    projects="webapp_bloomhealth webapp_bhbo bloomhealth"
    for project in $projects; do
        pushd $BLOOM_GIT_SANDBOX/$project > /dev/null
        git fetch --all && git pull
        popd > /dev/null
    done
}

function git-fu() {
    bloomLogo
    projects="webapp_bloomhealth webapp_bhbo bloomhealth"
    for project in $projects; do
        pushd $BLOOM_GIT_SANDBOX/$project > /dev/null
        git fetch upstream && git pull
        popd > /dev/null
    done
}

function gradle-bi() {
    if [ -f gradle.properties ]; then
        gradle -p libs pTML &&
            gradle -p services pTML &&
            gradle -p plugins pTML
    else
        echo "not in the bloomhealth repo"
    fi
}

function bloom-build-world() {
    echo "Building the Bloom World!"
    bloomLogo
    git-fu
    gradle_projects="bloomhealth"
    for project in $gradle_projects; do
        echo "Installing library '${project}'..."
        pushd $BLOOM_GIT_SANDBOX/$project > /dev/null
        gradle clean
        gradle publishMavenJavaPublicationToMavenLocal -Psnapshot=true || \
            gradle pTML
        popd > /dev/null
    done

    grails_projects="webapp_bloomhealth/bloomhealth webapp_bhbo/bhbo bloomhealth/webapps/consumer"
    for project in $grails_projects; do
        echo "Building '${project}'..."
        pushd $BLOOM_GIT_SANDBOX/$project > /dev/null
        grails clean && grails compile && grails package
        popd > /dev/null
    done
}

function gs-run() {
    if [ "$1" == "m" ]; then
        service='member'
    elif [ "$1" == "e" ]; then
        service='employer-graph'
    elif [ "$1" == "p" ]; then
        service='product'
    elif [ "$1" == "u" ]; then
        service='user'
    else
        echo "you must pass a parameter, one of:"
        echo " e: employer (graph)"
        echo " p: product"
        echo " m: member"
        echo " u: user"
        exit 1
    fi

    run=run
    if [ "$2" == "v" ]; then
        run=runVagrant
    fi

    pushd $BLOOM_GIT_SANDBOX/bloomhealth
    echo "gradle -p services/${service}/${service}-service ${run}"
    gradle -p services/${service}/${service}-service ${run}
    popd
}

function g-findword() {
    grep --include '*.java' --include '*.groovy' --include '*.gsp' --include '*.gradle' -rE "\<${1}\>" .
}

function j-findword() {
    grep --include '*.js' --include '*.html' --include '*.css' -rE "\<${1}\>" .
}

alias gr-install="gradle pTML -Psnapshot=true"

export simple_arrow='→'

function scrap() {
    vim ~/.scrap.groovy
}

export simple_fail='!'
export fancy_arrow='➦'
export fancy_fail='✘'
export beer='🍺 '

#export PS1='\e[1;32m\w\e[1;37m$(hgmin_ps1)$(gitmin_ps1)\e[1;34m `date`\e[0m\n${fancy_arrow} '
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

export PS1='\e[1;32m\w\e[1;37m$(__git_ps1 " [%s]")\e[1;34m `date`\e[0m\n${beer} '

# Docker port
export DOCKER_HOST=tcp://127.0.0.1:4243

. $HOME/lib/git-completion.bash

java7

set -o vi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" && ! $(which gvm-init.sh) ]] && source "$HOME/.gvm/bin/gvm-init.sh"
