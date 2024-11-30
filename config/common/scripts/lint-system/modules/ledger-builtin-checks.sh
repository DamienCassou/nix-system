#!/usr/bin/env bash

set -e

hledger --auto check --strict payees ordereddates recentassertions
