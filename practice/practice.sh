#!/usr/bin/env bash

function sayHi() {
  echo "Hello, $user!"
}

user=$LOGNAME
if [ -n $user ]; then
	sayHi
fi

