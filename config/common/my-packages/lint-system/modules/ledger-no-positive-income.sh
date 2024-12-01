#!/usr/bin/env bash

set -e

hledger --auto register ^income 'amt:>=0' \
    | wc --lines \
    | grep --quiet "^0$"
