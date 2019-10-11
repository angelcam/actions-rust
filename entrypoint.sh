#!/bin/sh -l

# By default HOME is set to /github/home
# this will cause that the new toolchains are not visible
export HOME=/root/

mkdir -p ~/.ssh/
echo "${INPUT_SSH_KEY}" > ~/.ssh/id_rsa
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/id_rsa

set -ex

wc -l ~/.ssh/id_rsa
git clone git@github.com:angelcam/rust-ac-http-server.git /tmp/testik


cargo $1 $2 $3
