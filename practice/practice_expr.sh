#!/bin/bash

clear

# use expr to get the result, the blank space between operators and numbers cannot be omitted
expr 3 + 2
echo

val=`expr 2 \* 2` # + - * /, * need to be escaped, and you need to add ' ' between operators
echo "result is $val"
echo "you can also use \$(()) instead of expr, result = $((2 * 8))"
echo

# another way to use calculation expression
((result=2*3))
echo result: $result
echo

echo after subtraction: $((result-4))
echo 

echo final result: $((result > 1? ++result: --result)) 

# 10(10)=2^3+2=1010, >> 1, 101=2^2+1=5(10)
echo bit opperation: $((10>>1))
echo


# use let to assign value to variable
let r=2+5
echo variable value: $r

