#!/usr/bin/env bash

clear

TEMPFILE=$(mktemp) || exit 1
echo TEMP file created: $TEMPFILE
echo

ls /etc/ > $TEMPFILE
cat $TEMPFILE
echo

if grep -qi "ssh" $TEMPFILE; then
    echo "find ssh in folder $TEMPFILE"
fi

trap 'echo "=================done================"' EXIT
