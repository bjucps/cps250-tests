
require-files --test-message "lab2.txt submitted" lab2.txt 

exit-if-must-pass-tests-failed

DIFFERENT_LINES=$(diff -y --suppress-common-lines lab2.txt $TEST_DIR/lab2solution.txt | wc -l)

# if file lab2.txt | grep CRLF > /dev/null;
# then
#   echo "Note: lab2.txt contains Windows line endings (did you forget to convert to Unix format?)." > diffreport.txt
# fi

echo "There are $DIFFERENT_LINES line(s) different between your lab2.txt and the official solution." 

result=$PASS
if [ $DIFFERENT_LINES -gt 0 ]; then
  echo "*** Expected Output ***                                       | Your lab2.txt" 
  diff -y $TEST_DIR/lab2solution.txt  lab2.txt
  result=$FAIL
fi

report-result $result "Warnings" "No differences with official solution"

require-files --test-message "report submitted" report.md
