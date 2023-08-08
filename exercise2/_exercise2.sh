require-files --test-message "linkcheck.sh submitted" linkcheck.sh 

exit-if-must-pass-tests-failed

# start web server
python3  -m http.server 8080 --directory $TEST_DIR &
sleep 1

# Remove any .txt or .html files, if submitted...
rm *.txt *.html 2>/dev/null

run-program --test-message "linkcheck runs without error" --timeout 5 --showoutputonpass bash linkcheck.sh http://localhost:8080/tests/ex2sample.html

pkill -f python3 # kill web server

require-pdf report.pdf
