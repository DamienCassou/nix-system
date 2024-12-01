#!/usr/bin/env bash

SCRIPTS=@modules@

# Takes a hashmap mapping test names to their exit status and list the
# test names whose exit status is not 0.
report_failures() {
    # The '2' in tests2 is only here because we can't name this
    # variable 'tests' (https://stackoverflow.com/a/29379084):
    local -n tests2=${1}

    echo There were failures: >&2

    # Iterate over each test name:
    for test in "${!tests2[@]}"; do
        local exit_status

        exit_status="${tests2[$test]}"

        if [[ $exit_status != 0 ]]; then
            echo - "${test}: Exit status was $exit_status" >&2
        fi
    done
}

main() {
    # Create a hashmap mapping test names to their exit status:
    declare -A tests

    local failure=0

    for file in "$SCRIPTS"/*.sh; do
        local exit_status
        echo "Executing ${file}" >&2
        bash "$file"
        exit_status=$?
        tests[$(basename "$file" .sh)]=$exit_status

        if [[ $exit_status != 0 ]]; then
            failure=1
        fi
    done

    if [[ $failure != 0 ]]; then
        report_failures tests
        exit 1
    fi

    echo "Successfully executed ${#tests[@]} tests" >&2
}

main
