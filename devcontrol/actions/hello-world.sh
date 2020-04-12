#!/bin/bash

# @description Hello world
#
# @example
#   hello-world
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode 0
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function hello-world() {

    # Init
    local briefMessage="Hello world"
    local helpMessage="Display 'Hello World' message"

    # Task choosing
    case $1 in
        brief)
            showBriefMessage "${FUNCNAME[0]}" "$briefMessage"
            ;;
        help)
            showHelpMessage "${FUNCNAME[0]}" "$helpMessage"
            ;;
        exec)
            echo "Hello World!"
            ;;
        *)
            showNotImplemtedMessage "$1" "${FUNCNAME[0]}"
            return 1
    esac
}

# Main
hello-world "$@"