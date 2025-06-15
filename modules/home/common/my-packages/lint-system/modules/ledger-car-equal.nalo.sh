#!/usr/bin/env bash

set -e

# The amounts of the 2 accounts should be the same

hledger --auto balance --empty --format "%(total)" ^budget:savings:nalo:car ^asset:fixed:nalo:car \
    | head -n 2 \
    | uniq \
    | wc --lines \
    | grep --quiet "^1$"
