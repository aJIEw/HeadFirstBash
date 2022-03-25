#!/bin/bash

# use expr, the blank between operators and numbers cannot be omitted
expr 3 + 2
echo

val=`expr 2 \* 2` # + - * /, * need to be escaped, and you need to add ' ' between operators
echo "sum is $val"
echo "you can also use $(()) instead of expr, result = $((2 * 8))"
echo

# another way to use calculation expression
((result=2*3))
echo result is $result
echo

echo now result is $((result-4))
echo 

# 10(10)=2^3+2=1010, >> 1, 101=2^2+1=5(10)
echo bit opperation: $((10>>1))
echo


# use let to assign value to variable
let r=2+5
echo result is $r
