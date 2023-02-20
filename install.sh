#!/bin/bash

path_set=$(echo "$PATH" | grep -oP ":?\/home\/.+\/\.local\/bin:?" | wc -c)

if [[ "$path_set" -eq 0 ]]; then
    echo -e 'Add this line to your rc file\n'
    echo 'export PATH=$HOME/.local/bin:$PATH'
fi

echo "Creating ${HOME}/.local/bin if does not exist"
mkdir -p ~/.local/bin

echo "Copying ./bin/host/pwn-env and ./bin/host/pwndbg to ${HOME}/.local/bin"
cp ./bin/host/pwn-env ./bin/host/pwndbg ~/.local/bin/
