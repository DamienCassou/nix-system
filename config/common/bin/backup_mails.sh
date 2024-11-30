#!/usr/bin/env bash

# This script moves all emails of a year passed as parameter to the
# archives account (in $MAILDIR/archives). By doing so, the next email
# synchronization with an IMAP server will delete the backed up emails
# from the server, making future synchronizations much faster.

# Use it like this:
#
# backup_mails.sh 2013

MAILDIR=$(realpath "$MAILDIR")

if [[ $# -ne 1 || $1 -lt 2000 || $1 -gt 2050 ]]; then
    echo "Usage: $0 <YEAR>"
    exit 1
fi

year=$1

if [[ ! -d $MAILDIR ]]; then
    echo "Please set MAILDIR before using this script!" >&2
    exit 1
fi

notmuch new || exit 1

tmp=$(mktemp)

notmuch \
    search --format=text0 --output=files \
    "date:$year-01-01..$year-12-31" | \
    grep --invert-match --null-data "^$MAILDIR/archives" \
         > $tmp

while read -r -d '' mail; do
    backup_1_mail.sh "$year" "$mail"
done < $tmp
