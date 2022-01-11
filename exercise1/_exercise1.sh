require-files --test-message "ex1.sh submitted" ex1.sh 

exit-if-must-pass-tests-failed

tar zxf $TEST_DIR/ftp.tar.gz

rm *.txt 2>/dev/null

echo Executing ex1.sh...
. ex1.sh 

echo -en Checking for log files produced by ex1.sh...
result=$PASS
if [ -z "$(ls log*.txt)" ]; then
  result=$FAIL
fi
echo $result
report-result $result "$CAT_MUST_PASS" "At least one log.txt file produced."

echo Files produced:
ls log*.txt

require-pdf report.pdf
