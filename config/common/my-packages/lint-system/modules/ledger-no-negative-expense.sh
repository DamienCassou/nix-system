#!/usr/bin/env bash

set -e

hledger --auto register ^expense 'amt:<=0' \
    | wc --lines \
    | grep --quiet "^0$"
