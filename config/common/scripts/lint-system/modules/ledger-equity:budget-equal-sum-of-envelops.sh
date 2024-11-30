#!/usr/bin/env bash

set -e

hledger --auto balance --depth 1 ^equitybudget ^budget \
    | tail -n 1 \
    | grep --quiet "^ *0 *$"
