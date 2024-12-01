#!/usr/bin/env bash

set -e

# Used accounts are all marked with tag:postable

invalidAccounts=$(hledger accounts --used "not:tag:postable")

if [[ -z ${invalidAccounts} ]]; then
    exit 0;
fi

echo There are "$(echo "${invalidAccounts}" | wc --lines)" accounts with transactions but not tagged as "postable":
echo "${invalidAccounts}"
exit 1
