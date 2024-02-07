require-files --test-message "Submitted ss.c" ss.c
do-compile --always-show-output --test-message "ss.c compiles with -g+ASAN" gcc -g -oss_asan -fsanitize=address ss.c -lbsd

require-files --test-message "Submitted sl.c" sl.c
do-compile --always-show-output --test-message "sl.c compiles with -g+ASAN" gcc -g -osl_asan -fsanitize=address sl.c -lbsd

exit-if-must-pass-tests-failed

forbidden-string-function-check ss.c
forbidden-string-function-check sl.c
require-files --test-message "Submitted report.txt" report.txt

for ss_tin in $TEST_DIR/ss_tests/ss_t*.in; do
	ss_tout="${ss_tin%%.in}.out"
        tname="$(basename ${ss_tin%%.in})"
	run-program --test-message "SS Test: $tname" --expected "$ss_tout" --input "$ss_tin" ./ss_asan
done

for sl_tin in $TEST_DIR/sl_tests/sl_t*.in; do
	sl_tout="${sl_tin%%.in}.out"
        tname="$(basename ${sl_tin%%.in})"
	run-program --test-message "SL Test: $tname" --expected "$sl_tout" --input "$sl_tin" ./sl_asan 
done
