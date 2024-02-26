#!/bin/sh

if [ -z "$1" ]; then
	echo "usage: run.sh [-d] ASMTCODE [...]"
	exit 1
fi

if [ "$1" = "-d" ]; then
	DEBUG_OPT="-x"
	shift
else
	DEBUG_OPT=""
fi

ASMT="$1"
shift

SUBDIR="$PWD"
BASEDIR=$(realpath $(dirname "$0"))

cd "$BASEDIR"
docker run -it --rm -v "$SUBDIR:/submission_src" -v "$BASEDIR:/tests" bjucps/cps250-test /bin/bash $DEBUG_OPT "/tests/rundocker.sh" "$ASMT" "$@"
