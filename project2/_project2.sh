require-pdf report.pdf
require-files ucon.py

if [ -f ucon.py ]; then
	status=$(test -x ucon.py && echo "PASS" || echo "FAIL")
	report-result "$status" "Advisory" "./ucon.py marked 'executable'"
	
	status=$(head -n1 ucon.py | grep -q "^#!" && echo "PASS" || echo "FAIL")
	report-result "$status" "Advisory" "./ucon.py has '#!' shebang line"
fi

echo "Using $(python3 --version)..."
echo

run-program --test-category "Sanity Check" --test-message "Demo ./ucon.py --help" --showoutputonpass ./ucon.py --help

