# Bloom Vars
export BITBUCKET_SANDBOX="$HOME/dev/grails/bloom"

export PATH="$HOME/bin:$PATH"

. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/bitbucket-sandbox.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/bloom-logs.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/bloom-plugins.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/ctags.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/grep-colors.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/groovy-grails.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/java-home.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/ls-colors.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/mysql.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/rabbitmq.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/truecrypt-config-switch.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/markdown.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/vim_dev.sh
. $BITBUCKET_SANDBOX/bloom-dev-scripts/bash/prompt.sh

function bloom-update-plugins() {
    pushd ~/bc > /dev/null
    hg fetch && grails --non-interactive clean && grails --non-interactive compile && grails maven-install
    popd > /dev/null

    pushd ~/bd > /dev/null
    hg fetch && grails --non-interactive clean && grails --non-interactive compile && grails maven-install
    popd > /dev/null
}

function hg-bu() {
    branch=$1
    pushd ~/bc > /dev/null
    hg fetch && hg up ${branch}
    popd > /dev/null

    pushd ~/bd > /dev/null
    hg fetch && hg up ${branch}
    popd > /dev/null

    pushd ~/bh > /dev/null
    hg fetch && hg up ${branch}
    popd > /dev/null

    pushd ~/bo > /dev/null
    hg fetch && hg up ${branch}
    popd > /dev/null
}

export PS1='\e[1;32m\w\e[1;37m$(hgmin_ps1)$(gitmin_ps1)\e[1;34m `date`\e[0m\n→ '
