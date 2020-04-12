#!/bin/bash

# Init
SOURCE="https://raw.githubusercontent.com/tpbtools/devcontrol/master/devcontrol.sh"
TARGET="/usr/local/bin/devcontrol"

# Check
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
if [ -f "${TARGET}" ]; then
    echo "devcontrol is already installed in ${TARGET}. Aborting"
    exit 1
fi

# Install
curl -s ${SOURCE} -o ${TARGET}
if [ $? -eq 0 ]; then
    chmod 777 /usr/local/bin/devcontrol
    echo "devcontrol installed in ${TARGET}"
else
    echo "Error installing devcontrol. Try again later"
fi