#!/bin/bash
[ -e "t.conf" ] && . t.conf
TESTS=$(find -mindepth 1 -maxdepth 1 -type d|sed 's/^\.\///'|grep -v '^\.')
TOTAL=$(IFS="\n" echo "$TESTS"|wc -l)
CURRENT=1
TOTAL_VALID=0
PASSED=0
FAILED=0
PENDING=0
echo "Running tests:"
for test in $TESTS; do
  echo -e -n "${CURRENT}. ${test} : "
  CURRENT=$((CURRENT+1))
  if [ -e "${test}/out" ]; then
    ( echo -n "$PREPEND";
    [ -e "${test}/args" ] && cat "${test}/args";
    [ -e "${test}/in"   ] && echo "< ${test}/in"
    ) | sh | diff - "${test}/out"
    if [ $? -eq 0 ]; then
      PASSED=$((PASSED+1))
      echo -e "\033[32mpass\033[0m" 
    else
      FAILED=$((FAILED+1))
      echo -e "\033[31mfail\033[0m" 
    fi
    TOTAL_VALID=$((TOTAL_VALID+1))
  else
    PENDING=$((PENDING+1))
    echo -e "\033[33mpending\033[0m" 
  fi
done
cat <<END
Statistics: ($TOTAL_VALID test$([ $TOTAL_VALID -eq 1 ] || echo s) + $PENDING pending)
  Failed: $FAILED
  Passed: $PASSED
END
exit $FAILED
