#!/usr/bin/env bash

clear

echo \~ expansion: ~
echo ? expansion: $(ls -al README.??)
echo \* expansion: $(ls a*.sh)
echo [] expansion: [a-z]*.sh
echo {} expansion: {a..c}*.sh
echo variable expansion: ${SHELL}
echo command substitution: $(date -R)
echo arithmetic expansion: $((2+2))
echo


