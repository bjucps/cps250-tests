require-files --test-message "Submitted ix.c" ix.c
do-compile --always-show-output --test-message "ix.c compiles with -g" gcc -g -oix ix.c -lbsd

exit-if-must-pass-tests-failed

require-files --test-message "Submitted report.txt" report.txt
forbidden-string-function-check ix.c

version=$(./ix <<<"this" | awk -f "$TEST_DIR/version_check.awk")
vstem=""
case "$version" in
	75)
		report-result "$PASS" "Warning"	"Version check passed (max 75)"
		vstem="max75"
		;;
	100)
		report-result "$PASS" "Warning"	"Version check passed (max 100)"
		vstem="max100"
		;;
	*)
		report-error "Warning" "Version check failed"
		;;
esac

if [ -n "$vstem" ]; then
	for ingz in "$TEST_DIR"/tests/*.in.gz; do
		base=$(basename "$ingz")
		outgz="$TEST_DIR/tests/${vstem}_${base%%.in.gz}.out.gz"
		infile="${ingz%%.gz}"
		outfile="${outgz%%.gz}"
		if zcat "$outgz" >"$outfile" && zcat "$ingz" >"$infile"; then
			run-program --test-message "IX Test: $base ($vstem)" --expected "$outfile" --input "$infile" ./ix
			rm -f "$infile" "$outfile"
		else
			report-error "Warning" "Failed to unpack expected $vstem output for $base"
		fi
	done
fi
