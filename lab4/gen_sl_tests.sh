#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "usage: $0 REF_IMP_SL_CMD..."
	exit 1
fi
REF_IMP_CMD="$*"

TNUM=1

function gen-test {
	local INFN="sl_tests/sl_t$TNUM.in"
	local OUTFN="sl_tests/sl_t$TNUM.out"
	TNUM=$((TNUM + 1))
	
	tee "$INFN" | $REF_IMP_CMD >$OUTFN
}

# delete 1, enter 42, insert at 1, select 'a'
gen-test<<EOF
1
42
1
a
EOF

# delete out of range (implied 0), insert at 3 (end of list), select 'b'
gen-test<<EOF
-5
1337
3
b
EOF

# delete 0, insert out of range (implied end of list), select 'c'
gen-test<<EOF
0
1969
1000
c
EOF

# delete/insert out of range, select 'x' (no such option)
gen-test<<EOF
100
4
200
x
EOF
