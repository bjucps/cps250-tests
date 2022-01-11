require-files --test-message "linkcheck.sh submitted" linkcheck.sh 

exit-if-must-pass-tests-failed

sudo python3  -m http.server 80 --directory $TEST_DIR &
sleep 1

# Remove any .txt or .html files, if submitted...
rm *.txt *.html 2>/dev/null

chmod +x linkcheck.sh
run-program --test-message "linkcheck runs without error" --timeout 5 --showoutputonpass ./linkcheck.sh http://localhost/tests/ex2sample.html

require-pdf report.pdf
