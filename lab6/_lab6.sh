require-files --test-message "Makefile required (at least)" Makefile
do-compile --always-show-output --test-message "Builds with make" make
require-files --test-message "Build produced ./client" ./client
require-files --test-message "Build produced ./server" ./server

exit-if-must-pass-tests-failed

forbidden-string-function-check client.c
forbidden-string-function-check server.c
forbidden-string-function-check common.c
require-files --test-message "Submitted report.txt" report.txt


