#!/bin/bash

# @description Start the platform
#
# @example
#   start
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function start() {

    # Init
    local briefMessage="Environment start and load initial data"
    local helpMessage="Start the docker-compose platform"

    # Task choosing
    case $1 in
        brief)
            showBriefMessage ${FUNCNAME[0]} "$briefMessage"
            ;;
        help)
            showHelpMessage ${FUNCNAME[0]} "$helpMessage"
            ;;
        exec)
            checkDocker
            docker-compose up -d
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
start "$@"