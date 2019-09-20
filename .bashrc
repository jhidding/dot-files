# Use global profile when available
if [ -f /usr/share/defaults/etc/profile ]; then
	. /usr/share/defaults/etc/profile
fi

# allow admin overrides
if [ -f /etc/profile ]; then
	. /etc/profile
fi

# set path
export PATH="${HOME}/.local/bin:${PATH}"

# load GHC preferences
if [ -f ${HOME}/.ghcup/env ]; then
        . ${HOME}/.ghcup/env
fi

# load Nix
if [ -f ${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then
        . ${HOME}/.nix-profile/etc/profile.d/nix.sh
fi

# configure NPM
export NPM_PACKAGES="${HOME}/.local/pkg/npm"
export NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"

# Set prompt
case "$TERM" in
xterm*|x-term*)
	export VIRTUAL_ENV_DISABLE_PROMPT=1
	source setup-shell-bar.sh return-value venv git
	;;
*)
	;;
esac

# Aliasses
alias vim='gvim -v'

# Python virtual envs
export WORKON_PATH="${HOME}/.local/share/workon"

function workon() {
    source ${WORKON_PATH}/${1}/bin/activate
}

function create-python3-env() {
    python -m virtualenv -p python3 ${WORKON_PATH}/${1}
}

_workon()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(ls ${WORKON_PATH})"

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -o nospace -F _workon workon

# Setup .local
export CFLAGS="-I${HOME}/.local/include ${CFLAGS}"
export LDFLAGS="-L${HOME}/.local/lib ${LDFLAGS}"

