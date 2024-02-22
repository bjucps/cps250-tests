require-files --test-message "Submitted lru.c" lru.c
do-compile --always-show-output --test-message "lru.c compiles with -g+ASAN" gcc -g -olru -fsanitize=address lru.c -lbsd

exit-if-must-pass-tests-failed

forbidden-string-function-check lru.c
require-files --test-message "Submitted report.txt" report.txt

(while IFS="," read infile slots outfile; do
	if [ -f "$TEST_DIR/tests/$infile" ]; then
		run-program --test-message "LRU Test: $infile/$slots" --expected "$TEST_DIR/tests/$outfile" --input "$TEST_DIR/tests/$infile" ./lru "$slots"
	fi
done) < $TEST_DIR/tests/tests.csv
