#!/bin/bash


# Give grails just as much memory as is on the production system
#export GRAILS_OPTS="-Xms2048m -Xmx2048m -XX:PermSize=128m -XX:MaxPermSize=1024m -server"
#export GRAILS_OPTS="-Xms2g -Xmx2g -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -server"
# new settings based on John E's suggestion

#export GRAILS_OPTS="-Xms1g -Xmx1g  -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -server"

# Grails - Interactive Mode
function g-ia() {
    grails -Duser.timezone=UTC interactive
}

# Grails - clean, compile & package
function g-ccp() {
    grails clean && grails compile --non-interactive && grails package --non-interactive
}

# Grails - Run all tests
function g-ta() {
    grails -Duser.timezone=UTC test-app $*
}

# Grails - Run unit tests
function g-tau() {
    grails -Duser.timezone=UTC test-app unit: $*
}

# Grails - Run unit tests
function g-taus() {
    grails -Duser.timezone=UTC test-app unit:spock $*
}

# Grails - Re-run failed unit tests
function g-taurr() {
    grails -Duser.timezone=UTC test-app -rerun unit: $*
}

# Grails - Run integration tests
function g-tai() {
    if [ -d logs ]; then
        rm logs/*
    fi
    grails -Duser.timezone=UTC test-app integration: $*
}

# Grails - Run integration tests
function g-tais() {
    if [ -d logs ]; then
        rm logs/*
    fi
    grails -Duser.timezone=UTC test-app integration:spock $*
}

# Grails - Re-run failed integration tests
function g-tairr() {
    if [ -d logs ]; then
        rm logs/*
    fi
    grails -Duser.timezone=UTC test-app -rerun integration: $*
}

# Grails - Run fitness tests
function g-tafit() {
    grails -Duser.timezone=UTC test-app fitnesse: $*
}

# Grails - Run functional tests
function g-tafun() {
    if [ -d logs ]; then
        rm logs/*
    fi
    grails -Duser.timezone=UTC test-app functional: $*
}

# Grails - Re-run functional tests
function g-tafunrr() {
    if [ -d logs ]; then
        rm logs/*
    fi
    grails -Duser.timezone=UTC test-app -rerun functional: $*
}

function g-finduses() {
    if [ "$1" == "" ]; then
        echo "usage: $0 classOrFunctionName"
    else
        echo -e "grails-app:\n==========="
        grep --include '*.groovy' --include '*.gsp' -rE "\<$1\>" grails-app/
        echo -e "web-app:\n==========="
        grep --include '*.js' -rE "\<$1\>" web-app/
        echo -e "\nsrc:\n==========="
        grep --include '*.groovy' -rE "\<$1\>" src/
        echo -e "\ntest:\n==========="
        grep --include '*.groovy' -rE "\<$1\>" test/
    fi
}
