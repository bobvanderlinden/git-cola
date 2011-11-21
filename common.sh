#!/bin/sh
unset CDPATH

curdir="$(pwd)"
cd "$(dirname "$0")"
META="$(pwd)"
cd "$curdir"
unset curdir

# _the_ cola version
if test -e bin/git-cola
then
	VERSION=$(bin/git-cola version | awk '{print $3}')
fi

WEB_SOURCE="$HOME"/src/cola-web

if test -e "$META"/config.sh
then
	. "$META"/config.sh
fi

do_or_die() {
	if ! "$@"; then
		status=$?
		echo "error running: $@"
		echo "exit status: $status"
		exit $status
	fi
}

title() {
	echo
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "    $@"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo
}

ensure_dir_exists() {
	if ! test -d "$1"; then
		do_or_die mkdir -p "$1"
	fi
}
