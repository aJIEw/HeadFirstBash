#!/bin/bash

function show_usage_and_exit() {
    echo "script usage: $(basename $0) [-l] [-h] [-a somevalue]" >&2
    exit 1
}

if [[ ! $1 =~ ^-[a-zA-z]+$ ]]; then
    echo illeage arguments!!
    show_usage_and_exit
fi


while getopts 'lha:p:' opt; do
    case "$opt" in
        l)
            echo "l stands for list"
            ;;
        h)
            echo "h stands for help"
            ;;
        a)
            echo "a value is $OPTARG"
            ;;
        p)
            echo "p value is $OPTARG"
            ;;
        *)
            show_usage_and_exit
            ;;
    esac
done

shift "$(($OPTIND - 1))"

echo left args: $@

