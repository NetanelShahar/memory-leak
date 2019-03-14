#!/bin/bash
foldername=$1
executeble=$2
argument=$3

curentLocation=`pwd`

cd $foldername

make &> output.txt

successfulmake=$?
if [ $successfulmake -gt 0 ]
then
echo ‫‪Compilation‬‬      memoryleaks        threadrace
echo     fali            fail                fail
rm output.txt
exit 7
fi


valgrind --tool=helgrind --error-exitcode=1 ./$executeble $argument &> output.txt
helgrindresult=$?
if [ $helgrindresult -gt 0 ];then
helgrind=Fail
else 
helgrind=pass
fi

valgrind --leak-check=full --error-exitcode=1 ./$executeble $argument &> output.txt
valgrindresult=$?
if [ $valgrindresult -gt 0 ] ;then
valgrind=Fail
else 
valgrind=pass
fi

echo ‫‪Compilation‬‬      memoryleaks        threadrace
echo     pass          $valgrind          $helgrind

if [ $valgrindresult -gt 0 ]
then
if [ $helgrindresult -gt 0 ]
then
rm output.txt
exit 3
else
rm output.txt
exit 2
fi
fi

if [ $helgrindresult -gt 0 ]
then
if [ $valgrindresult -eq 0 ]
then
rm output.txt
exit 1
fi
fi

rm output.txt
exit 0
