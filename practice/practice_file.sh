#!/bin/bash

# -a or -e, file exists; -f, file exists and is not directory or other files; -d, file is a directory;
# -s, file exists and is not empty;
# -w or -r, has write or read permission; -x, has execute permission;
if [ -a practice.sh ]; then
	echo practice.sh exists
fi
echo

# use `` to wrap command or expressions
for file in `ls ./`; do
	echo $file info: `ls -al $file`
done
echo

