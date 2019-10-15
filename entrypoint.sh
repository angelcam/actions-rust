#!/bin/sh -l

# By default HOME is set to /github/home
# this will cause that the new toolchains are not visible
export HOME=/root/

# Store private ssh key passed by env variable
echo "${INPUT_SSH_KEY}" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

set -ex

cargo $1 $2 $3
