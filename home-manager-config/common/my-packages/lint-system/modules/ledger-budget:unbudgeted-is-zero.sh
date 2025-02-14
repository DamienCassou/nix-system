#!/usr/bin/env bash

set -e

hledger --auto balance --empty ^budget:unbudgeted \
    | grep --quiet "^ *0 *budget:unbudgeted *$"
