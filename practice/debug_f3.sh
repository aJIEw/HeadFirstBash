#!/usr/bin/env bash


function another_in_f3() {
    echo inside another_in_f3
    echo BASH_SCRIPT[0]: ${BASH_SOURCE[0]}
    echo BASH_SCRIPT[1]: ${BASH_SOURCE[1]}
    echo BASH_SCRIPT[2]: ${BASH_SOURCE[2]}
    echo BASH_SCRIPT[3]: ${BASH_SOURCE[3]}
}

function f3() {
    echo inside f3
    another_in_f3
}

f3

