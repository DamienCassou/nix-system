#!/usr/bin/env bash

set -e

hledger --auto balance --empty ^budget:available \
    | grep --quiet "^ *0 *budget:available *$"
