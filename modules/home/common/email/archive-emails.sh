#!/usr/bin/env bash

# This script makes sure that a treated email (one without the inbox
# tag) disappear from the INBOX folder. This is useful when using
# K9Mail which doesn't know about notmuch tags.

# How it is implemented: when an email is in an account's INBOX/
# sub-folder but does not have an inbox tag, move it to the account's
# Archive/ sub-folder.

# Executed as a notmuch hook (see man notmuch-hooks)

tmp=$(mktemp --tmpdir 'notmuch-hook-pre-new-XXXXXXXX')
notmuch search --format=text0 --output=files '(NOT tag:inbox) AND (folder:Perso/INBOX)' | grep -z 'INBOX/\(cur\|new\)' > $tmp

# Declares a new table
archived=()

while read -r -d '' mail; do
    dest=$(dirname $mail)/../../Archive/cur/
    if [[ ! -d $dest ]]; then
        echo "Non existing $dest" >&2
        echo "Can't move $mail there!"
        exit 1
    fi
    if [[ -f $mail ]]; then
        subject=$(cat $mail | grep '^Subject:')
        archived+=("$subject")
        mv "$mail" "$dest"
    else
        echo "Non existing $mail. That's strange. Trying to clean the database:"
        notmuch new --no-hooks
    fi
done < $tmp

if [[ ${#archived[@]} -eq 0 ]]; then
    echo No mail to archive
else
    echo "${#archived[@]} email(s) have been archived:"
    for mail in "${archived[@]}"; do
        echo "$mail"
    done
fi
