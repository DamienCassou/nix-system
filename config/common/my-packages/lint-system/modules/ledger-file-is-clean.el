(progn
  (find-file "/tmp/accounting.clean.ledger")
  (ledger-mode-clean-buffer)
  (save-buffer)
  (let ((result (call-process
                 "diff" nil nil nil
                 "--text"
                 "--brief"
                 "/tmp/accounting.clean.ledger"
                 "/home/cassou/configuration/ledger/accounting.hledger")))
    (kill-emacs
     (if (equal result 0)
         0
       1))))
