#!/bin/bash

phony=
action() {
        echo "$1"
        if [ -z "$phony" ]
        then
                eval "$2"
        else
                echo ">    $2"
        fi
}

show_help() {
        echo "Installs all Vim packages listed."
        echo
        echo "options:"
        echo "    -h    help, show this help message."
        echo "    -p    phony, print actions but don't act."
        echo "    -t    target, target vim dir (default ~/.vim)."
        echo
        echo "Vim has native package support. Packages are installed"
        echo "into \"~/.vim/pack/<bundle>/<package>\", and symlinks"
        echo "are generated into \"~/.vim/pack/<bundle>/start\"."
        echo
        echo "This tool installs these packages as described in a"
        echo "ini/toml format, looking like:"
        echo
        echo "    [core]"
        echo "    editorconfig-vim = \"git@github.com:editorconfig..."
        echo "    VOoM = \"git@github.com:vim-voom/VOoM.git\""
        echo
        echo "    [themes]"
        echo "    gruvbox = \"git@github.com:morhetz/gruvbox.git\""
        echo
        echo "You may generate such a list by running the"
        echo "\"list-vim-packages.sh\" script, found in this same"
        echo "distribution."
}

show_usage() {
        echo "usage: $0 [-n] [-h] [-t <path>] < input.toml"
}

target="${HOME}/.vim"
while getopts "hpt:" arg
do
        case $arg in
        h)      show_help && exit 0
                ;;
        t)      target=$(realpath ${OPTARG})
                ;;
        p)      phony=1
                ;;
        ?)      show_usage && exit 2
                ;;
        esac
done

if [ ! -z "$phony" ]
then
        echo "Phony run:"
fi

create_start() {
        if [ -z "$1" ]; then
                return
        fi

        action "   creating start" "mkdir start && cd start"
        for f in $1; do
                action "      making symlink to $f" "ln -s ../$f ."
        done
        cd ..
}

pack=
handle_line() {
        if [[ "$1" =~ \[(.*)\] ]]
        then
                create_start "$pack"
                path="${target}/pack/${BASH_REMATCH[1]}"
                action "Entering ${path} ..." "mkdir -p ${path} && cd ${path}"
                pack=""
                return
        fi

        if [[ "$1" =~ ([^= ]*)\ *\=\ *\"([^\"]*)\" ]]; then
                pkg_name="${BASH_REMATCH[1]}"
                git_address="${BASH_REMATCH[2]}"
                pack="${pack} ${pkg_name}"
                action "   cloning ${pkg_name}" "git clone -q ${git_address} ${pkg_name}"
                return
        fi

        if [[ "$1" =~ \ * ]]; then
                return
        fi

        echo "no match for: $1"
        exit 1
}

while read line
do
        handle_line "$line"
done
create_start "${pack}"

