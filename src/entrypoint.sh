#!/bin/sh

set -eu
set -o pipefail

if [ ! -z "$SSH_KEY" ]; then
    eval "$(ssh-agent -s)" >> /dev/null
    echo "$SSH_KEY" > ~/.ssh/id_rsa
    chmod 400 ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
fi

exec $@