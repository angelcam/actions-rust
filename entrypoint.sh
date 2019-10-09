#!/bin/sh -l

# By default HOME is set to /github/home
# this will cause that the new toolchains are not visible
export HOME=/root/

sleep 1

set -ex

cargo $1 $2 $3
