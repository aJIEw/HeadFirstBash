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


add() {
    local regex_num=^-?[0-9]+$
    if [[ $1 =~ $regex_num && $2 =~ $regex_num ]]; then
        return $(($1+$2))
    else
        echo illegal arguemnts: $1, $2
    fi
}

add 1 9
result=$?
echo after add: $result


