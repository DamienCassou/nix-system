#!/usr/bin/env bash

set -e

CURRENT_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -f "${LEDGER_FILE}" /tmp/accounting.clean.ledger

exec emacs --batch --no-window-system \
     --no-init-file --no-site-file --no-splash \
     --eval "(add-to-list 'load-path \"~/.emacs.d/lib/ledger-mode\")" \
     --load "ledger-mode" \
     --load="${CURRENT_SCRIPT_DIR}/ledger-file-is-clean.el" \
     1>/dev/null 2>&1
