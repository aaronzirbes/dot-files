#!/bin/bash

function cloneRepo() {
    if [ ! -d ~/.files/ ]; then
        echo "cloning https://github.com/aaronzirbes/dot-files.git to ~/.files"
        git clone https://github.com/aaronzirbes/dot-files.git ~/.files
    else
        echo "~/.files/ already exists. skipping clone."
    fi
}

function linkit() {
    source_file="${1}"
    dest_file="${2}"

    if [ ! -e ~/${dest_file} ]; then
        echo "Linking '${source_file}' to '${dest_file}'..."
        ln -s ~/.files/${source_file} ~/${dest_file}
    else
        echo -e -n "${source_file} already exists\n\t"
        ls -l ~/${source_file}
    fi

}

function linkall() {

    pushd ~/.files &> /dev/null

    for file in .gitconfig \
                .gitflow_export \
                .gitignore_global \
                .profile; do
        linkit ${file} ${file}
    done

    linkit .profile .bashrc

    popd &> /dev/null
}

function homebrew() {
    pushd ~/.files &> /dev/null
    brew bundle
    popd &> /dev/null
}

cloneRepo
linkall
homebrew

echo "Done!"

