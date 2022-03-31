#!/usr/local/bin/bash

clear

# if else statement
i="Five"
#i='One'
if [ ${#i} -eq 4 ]; then
    echo Hi${i}!
elif [ $i == "One" ]; then
    echo You are No.1!
else
    echo Nice to meet you, $i!
fi

s1='2'
s2='2'
if (( $s1 > $s2 )); then
    echo "s1 longer"
elif [ $s1 = $s2 ]; then
    echo "s1 = s2"
else
    echo "s2 longer"
fi


if [ -d practice ] && cd practice; then
    echo "Entered folder: practice"
fi

file="test file.sh"
echo file is: $PWD/$file
if [ -a "$PWD/$file" ]; then
    echo file exists
else
    echo file not found
fi

# regex example, use =~ to compare
read -p "Please input a number:" num
if [[ $num  =~ [6-9]+ ]]; then # use [[  ]] so we don't need to use quote and support && || > <, etc.
    echo in range
else
    echo not int range
fi
echo


read -p "please input your name:" input
case $input in
    aJIEw )
        echo "Hello, aJIEw" ;;
    Octocat )
        echo "Hello, Octocat" ;;
    * )
        echo "Sorry, I don't know who you are."
esac
echo


read -n 1 -p "Type a character > "
echo
case $REPLY in
  [[:upper:]] )    echo "'$REPLY' is upper case." ;;& # only supported by bash version larger than 4.0
  [[:lower:]] )    echo "'$REPLY' is lower case." ;;&
  [[:alpha:]] )    echo "'$REPLY' is alphabetic." ;;&
  [[:digit:]] )    echo "'$REPLY' is a digit." ;;&
  [[:graph:]] )    echo "'$REPLY' is a visible character." ;;&
  [[:punct:]] )    echo "'$REPLY' is a punctuation symbol." ;;&
  [[:space:]] )    echo "'$REPLY' is a whitespace character." ;;&
  [[:xdigit:]] )   echo "'$REPLY' is a hexadecimal digit." ;;&
esac


# show some condition check examples
function expression {
    statement1 && statement2   # both statements are true
    statement1 || statement2   # at least one of the statements is true

    expression1 && expression2 # if expression1 executed with no error, then execute expression2
    expression1 || expression2 # if expression1 executed with error, then execute expression2

    str1 = str2     # str1 matches str2
    str1 != str2    # str1 does not match str2
    str1 < str2     # str1 is less than str2
    str1 > str2     # str1 is greater than str2
    -n str1         # str1 is not null (has length greater than 0)
    -z str1         # str1 is null (has length 0)

    -a file         # file exists
    -d file         # file exists and is a directory
    -e file         # file exists; same -a
    -f file         # file exists and is a regular file (i.e., not a directory or other special type of file)
    -r file         # you have read permission
    -s file         # file exists and is not empty
    -w file         # you have write permission
    -x file         # you have execute permission on file, or directory search permission if it is a directory
    -N file         # file was modified since it was last read
    -O file         # you own file
    -G file         # file's group ID matches yours (or one of yours, if you are in multiple groups)

    file1 -nt file2     # file1 is newer than file2
    file1 -ot file2     # file1 is older than file2

    -lt     # less than
    -le     # less than or equal
    -eq     # equal
    -ge     # greater than or equal
    -gt     # greater than
    -ne     # not equal
}

