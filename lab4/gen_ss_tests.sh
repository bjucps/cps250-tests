#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "usage: $0 REF_IMP_SS_CMD..."
	exit 1
fi
REF_IMP_CMD="$*"

TNUM=1

function gen-test {
	local INFN="ss_tests/ss_t$TNUM.in"
	local OUTFN="ss_tests/ss_t$TNUM.out"
	TNUM=$((TNUM + 1))
	
	tee "$INFN" | $REF_IMP_CMD >$OUTFN
}

# basic one-word name
gen-test<<EOF
Fred
EOF

# empty line, one-word name
gen-test<<EOF
    
Fred
EOF

# one-word name with leading/trailing space
gen-test<<EOF
       Fred    
EOF

# normal name
gen-test<<EOF
Fred Smith
EOF

# normal name with leading/trailing spaces
gen-test<<EOF
    Fred Smith    
EOF

# wacky spacing name
gen-test<<EOF
	Fred   Smith	
EOF

# long name
gen-test<<EOF
Trumpington Fanhurst XXIV, Esq.
EOF

# J name
gen-test<<EOF
John Doe
EOF

# long J name (with spaces!)
gen-test<<EOF
  Julian Potterton-Brown  
EOF
