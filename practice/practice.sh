#!/usr/bin/env bash

clear

function sayHi() {
  echo "Hello, $user!"
}

user=$LOGNAME
if [ -n $user ]; then
	sayHi
fi

