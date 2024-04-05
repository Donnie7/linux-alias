#!/bin/bash

# Define the URL to your raw alias file on GitHub
ALIAS_URL="https://github.com/Donnie7/linux-alias/blob/main/my_alias"

# Define the destination based on the shell
if [ -n "$ZSH_VERSION" ]; then
    # Assume Zsh
    DEST="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    # Assume Bash
    DEST="$HOME/.bashrc"
else
    # Default to Bash
    DEST="$HOME/.bashrc"
fi

# Download and append the aliases to the shell configuration file
curl -s $ALIAS_URL >> $DEST

echo "Aliases synced successfully."
