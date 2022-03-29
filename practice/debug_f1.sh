#!/usr/bin/env bash

. debug_f2.sh
. debug_f3.sh

function f1() {
    echo inside f1
    echo ${FUNCNAME[0]} is called on line: $BASH_LINENO
    echo funcname1: ${FUNCNAME[1]}
    echo funcname2: ${FUNCNAME[2]}
    f2
}

f1

