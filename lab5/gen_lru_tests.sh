#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "usage: $0 REF_IMP_LRU_CMD..."
	exit 1
fi
REF_IMP_CMD="$*"

cd "$(dirname $(realpath "$0"))/tests"

awk -F, '$2 > 0 {print "'"$REF_IMP_CMD"' " $2 " <"$1 " >"$3 }' <tests.csv | sh
