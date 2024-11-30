#!/usr/bin/env bash

# This script moves an email (passed as parameter) to the correct
# backup folder. Use it from backup_mails.sh.

maildir=$(realpath "$MAILDIR")

archives_dirname="archives"

if [[ ! -d $maildir ]]; then
    echo "Please set MAILDIR before using this script!" >&2
    exit 1
fi

if [[ $# -ne 2 || $1 -lt 2000 || $1 -gt 2050 || ! -f $2 ]]; then
    echo "Usage: $0 <YEAR> <MAIL-FILE>"
    exit 1
fi

year="$1"

source="$2"
# e.g., source="/home/cassou/Mail/GMail/All Mail/cur/1419776396_1.10474.luz3,U=442584,FMD5=883ba13d52aa35908bd3344dc0604026:2,S"

# Convert to absolute path (normally won't change anything)
source=$(realpath "$source")
# e.g., source="/home/cassou/Mail/GMail/All Mail/cur/1419776396_1.10474.luz3,U=442584,FMD5=883ba13d52aa35908bd3344dc0604026:2,S"

# Remove prefix
source_relpath=$(echo "$source" | sed -e 's"^'$maildir'/""')
# e.g., source_relpath="GMail/All Mail/cur/1419776396_1.10474.luz3,U=442584,FMD5=883ba13d52aa35908bd3344dc0604026:2,S"

# Extract the directory containing the mail inside the maildir
source_dirname=$(dirname "$source_relpath")
# e.g., source_dirname="GMail/All Mail/cur"

account=$(echo "$source_dirname" | sed -e 's"^\([^/]*\)/.*$"\1"')
# e.g., account=GMail

if [[ $account = $archives_dirname ]]; then
    echo "Backing up a file already in the archive"
    exit 1
fi

archive_dir="${maildir}/${archives_dirname}/${year}/${source_dirname}"

mkdir -p "$archive_dir"

echo "Moving $source to ${archive_dir}"
mv "$source" "${archive_dir}/"
