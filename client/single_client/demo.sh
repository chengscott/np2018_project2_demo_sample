#! /bin/sh

CLIENT="./delayclient"
SERVER_IP=$1
SERVER_PORT=$2
OUTPUT_DIR="output"
TESTCASE_DIR="test_case"
ANSWER_DIR="answer"

if [ -z ${SERVER_IP} ] || [ -z ${SERVER_PORT} ]; then
  echo "Usage: $0 [server IP] [server port]"
  exit 1
fi

TEST_CASE_START=1

[ -n "$3" ] && TEST_CASE_START=$3

mkdir -p ${OUTPUT_DIR}
[ -n "$( which gmake )" ] && MAKE=gmake
[ -z "$( which gmake )" ] && MAKE=make
${MAKE} clean
${MAKE}

for i in $( seq ${TEST_CASE_START} 3 ); do
  echo "[1;34m===== Test case ${i} =====[m"
  rm -f ${OUTPUT_DIR}/${i}.txt
  ${CLIENT} ${SERVER_IP} ${SERVER_PORT} ${TESTCASE_DIR}/${i}.txt > ${OUTPUT_DIR}/${i}.txt
  diff -w ${OUTPUT_DIR}/${i}.txt ${ANSWER_DIR}/${i}.txt > /dev/null
  if [ $? -eq 0 ]; then
    echo "Your answer is [0;32mcorrect[m"
    correct_cases="${correct_cases} ${i}"
  else
    echo "Your answer is [0;31mwrong[m"
    wrong_cases="${wrong_cases} ${i}"
  fi
done

echo "[1;34m======= Summary =======[m"
[ -n "${correct_cases}" ] && echo "[0;32m[Correct][m:${correct_cases}"
[ -n "${wrong_cases}" ] && echo "[0;31m[ Wrong ][m:${wrong_cases}"
