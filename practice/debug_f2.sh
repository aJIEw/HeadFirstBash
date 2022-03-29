#!/usr/bin/env bash

function f2() {
    echo inside f2
    echo ${FUNCNAME[0]} is called on line: $BASH_LINENO
    echo funcname1: ${FUNCNAME[1]}
    echo funcname2: ${FUNCNAME[2]}
    f3
}

