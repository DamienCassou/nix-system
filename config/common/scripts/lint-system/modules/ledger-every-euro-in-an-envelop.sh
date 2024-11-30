#!/usr/bin/env bash

set -e

hledger --auto balance --depth 1 ^asset ^debt ^equitybudget \
    | tail -n 1 \
    | grep --quiet "^ *0 *$"
