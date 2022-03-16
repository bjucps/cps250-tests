function runit {
    echo "******************************************************"
    echo Executing $*...
    echo "------------------------------------------------------"
    $* 2>&1 | head -20
}

require-files httpv.c Makefile

# Compile httpv
[ -r httpv ] && rm httpv
do-compile --always-show-output --expect-exe httpv make

exit-if-must-pass-tests-failed

require-pdf report.pdf

forbidden-string-function-check httpv.c

cp $TEST_DIR/*.txt .

echo "------------------------------------------------------"
echo "Executing ./httpv < goodhttp01.txt..."
echo "------------------------------------------------------"
./httpv < goodhttp01.txt


runit ./httpv missingfile.txt

for FILE in good*.txt bad*.txt 
do
  runit ./httpv $FILE
done

if is-local-test; then
  runit valgrind ./httpv goodhttp02.txt 2>&1 | sed 's/^==[^=]*==/====/'
fi

exit 0
