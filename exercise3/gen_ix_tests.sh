#!/bin/bash

if [ "$#" -lt 2 ]; then
	echo "usage: $0 VTAG REF_IMP_IX_CMD ..."
	exit 1
fi
VTAG="$1"
shift
REF_IMP_CMD="$*"

TDIR="$(dirname $(realpath --relative-to="$PWD" "$0"))/tests"

for infile in $TDIR/*.in.gz; do
	base=$(basename "$infile")
	zcat "$infile" | $REF_IMP_CMD | gzip -c > "$TDIR/${VTAG}_${base%%.in.gz}.out.gz"
done
