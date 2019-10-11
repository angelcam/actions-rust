#!/bin/sh -l

# By default HOME is set to /github/home
# this will cause that the new toolchains are not visible
export HOME=/root/

mkdir -p ~/.ssh/
echo "${INPUTS_SSH_KEY}" > ~/.ssh/id_rsa
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/id_rsa

sleep 1

set -ex

cargo $1 $2 $3
