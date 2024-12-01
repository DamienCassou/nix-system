#!/usr/bin/env bash


file1="$1"
file2="$2"

if [[ ! -f $file1 || ! -f $file2 ]]; then
    echo "ERROR: Wrong call $*"
    echo "Usage: $0 FILE1 FILE2"
    exit 1
fi

target=$(mktemp)

emacsclient --create-frame --eval "(ediff3 \"$file1\" \"$file2\" \"$target\")" &

echo "Merge these two files into ${target}"
read -p "Press RET here when you are done (C-c to abort)... "

if [[ ! -s $target ]]; then
    echo "ERROR: The $target is non-existent or empty"
    exit 1
fi

cp "$target" "$file1"
cp "$target" "$file2"

echo "The merge went well, going on."
