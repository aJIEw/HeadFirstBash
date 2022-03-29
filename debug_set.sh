#!/usr/bin/env bash

set -Eeux
set -o pipefail
# set -o noclobber


if [ -a /etc ]; then
    echo do something
fi

f1

# shopt

echo 456 > 123.sh

fo | grep 1

echo "end"
