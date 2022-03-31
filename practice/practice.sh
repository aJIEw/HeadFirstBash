#!/usr/bin/env bash

clear

user=$LOGNAME

function sayHi() {
  echo "Hello, $user!"
}

if [ -n $user ]; then
    sayHi
fi

