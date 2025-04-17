require-pdf report.pdf
require-files ucon.py
run-program --test-category "Sanity Check" --test-message "Demo ./ucon.py --help" --showoutputonpass ./ucon.py --help

