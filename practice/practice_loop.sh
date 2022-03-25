#!/bin/bash

for (( i=1; i<10; i++ )); do
	echo three expression loop: $i
done
echo

for i in 1 10 15 8 100; do
	echo in loop: $i
	if [ $i -eq 8 ]; then
	echo "find 8 in this list, quit now"
	break
	fi
done
echo

for i in {1..10}; do
	echo in loop with range: $i
done
echo


