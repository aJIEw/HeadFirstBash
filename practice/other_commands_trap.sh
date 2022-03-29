#!/usr/bin/env bash

trap 'echo "=================done================"' EXIT

TEMPFILE=$(mktemp) || exit 1
echo $TEMPFILE

ls /etc/ > $TEMPFILE
cat $TEMPFILE
echo

if grep -qi "ssh" $TEMPFILE; then
    echo "find ssh in folder $TEMPFILE"
fi

