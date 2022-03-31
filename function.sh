!/bin/bash

clear

# an example of a function
function foo() {
    echo This is foo
}
foo

# another function example, you can omit the parenthesis
function print {
    echo $1
}
print "Hello world!"

# third way to create a function, omit the function keyword
today() {
    echo "Today's date: $(date +"%A, %B %-d, %Y")"
}
today

birth_year=1994
function intro() {
    local age=$((`date +%Y` - $birth_year))
    # use $ and number to get arguemnts
    echo "Hi, my name is $1, and I'm $age years old."
}
intro "aJIEw"


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


