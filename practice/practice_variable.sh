#!/usr/bin/env bash

clear

str="str"
echo ${str:-and}
echo ${null:-not_exist}
echo ${null:=set_value}
echo checking null value is $null
echo
