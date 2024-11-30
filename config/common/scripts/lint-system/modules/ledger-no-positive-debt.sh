#!/usr/bin/env bash

hledger --auto balance --format "%(total)" ^debt: \
    | head -n -2 \
    | grep --quiet --invert-match "^-"

if [[ (${PIPESTATUS[0]} -eq 0) && (${PIPESTATUS[1]} -eq 0) && (${PIPESTATUS[2]} -eq 1) ]]; then
    exit 0
else
    exit 1
fi
