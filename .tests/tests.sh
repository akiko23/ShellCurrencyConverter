#!/bin/bash

# some constants
sc=\\033[33m[SCRIPT]\\033[37m
success=\\033[32m[SUCCESS]\\033[37m
error=\\033[31m[ERROR]\\033[37m
info=\\033[35m[INFO]\\033[37m
test_data_path=currencies

chmod +x ../script.sh

# create files
mkdir $test_data_path
echo -e "1 USD RUB\n6 EUR AMD\n40000 RUB AMD" > $test_data_path/correct.txt
echo -e "34 EUR RUB\n5 AMD fkaskfk" > $test_data_path/incorrect.txt

echo 
echo -e "$info TEST SCRIPT WITH ARGS ENTERED FROM KEYBOARD"
echo -e "\n$sc Enter correct keyboard args"
../script.sh 1 USD RUB > log # correct args (exit code has to be 0)
if [[ $? -eq 0 ]]; then
  echo -e "$success Test 1 passed" 
else
  echo -e "$error Test 1 Failed"
fi

echo -e "\n$sc Enter incorrect keyboard args"
../script.sh asdk 3 akfskkf > log # wrong args (exit code has to be 1)
if [[ $? -eq 1 ]]; then
  echo -e "$success Test 2 passed"
else
  echo -e "$error Test 2 failed"
fi 
echo 

echo -e "\n$info TEST SCRIPT WITH OPTION -f AND FILE PATH"
echo -e "\n$sc Path to file is missing"
../script.sh -f > log # necessary arg (path to file) is missing
if [[ $? -eq 2 ]]; then
  echo -e "$success Test 3 passed"
else
  echo -e "$error Test 3 failed"
fi

echo -e "\n$sc File doesn\`t exist"
../script.sh -f kfdakfjd > log # file doesn`t exist (exit code has to be 3)
if [[ $? -eq 3 ]]; then
  echo -e "$success Test 4 passed"
else
  echo -e "$error Test 4 failed"
fi

echo -e "\n$sc Enter file with correct lines format"
../script.sh -f $test_data_path/correct.txt > log # correct file lines format (exit code has to be 0)
if [[ $? -eq 0 ]]; then
  echo -e "$success Test 5 passed"
else
  echo -e "$success Test 5 passed"       
fi

echo -e "\n$sc Enter file with incorrect lines format"
../script.sh -f $test_data_path/incorrect.txt > log # incorrect file lines format (exit code has to be 1)
if [[ $? -eq 1 ]]; then
  echo -e "$success Test 6 passed"
else
  echo -e "$error Test 6 failed"
fi

# remove extra data
rm log
rm -r $test_data_path

