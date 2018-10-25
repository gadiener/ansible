#!/bin/sh

set -eu
set -o pipefail


if [ ! -z "$SSH_KEY" ] || [ -r "$SSH_KEY_PATH" ]; then
    eval "$(ssh-agent -s)" >> /dev/null
fi

if [ ! -z "$SSH_KEY" ]; then
    echo "$SSH_KEY" > ~/.ssh/id_rsa
fi

if [ ! -z "$SSH_KEY_PATH" ] && [ -r "$SSH_KEY_PATH" ]; then
    chmod 400 $SSH_KEY_PATH
    ssh-add $SSH_KEY_PATH
fi

exec $@