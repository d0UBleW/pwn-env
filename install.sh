#!/bin/bash

path_set=$(echo "$PATH" | grep -oP ":?\/home\/.+\/\.local\/bin:?" | wc -c)

if [[ "$path_set" -eq 0 ]]; then
    echo -e 'Add this line to your rc file\n'
    echo 'export PATH=$HOME/.local/bin:$PATH'
fi

mkdir -p ~/.local/bin
cp ./pwn-env ./pwndbg ~/.local/bin/
