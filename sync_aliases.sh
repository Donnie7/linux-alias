#!/bin/bash

# Define the URL to your raw alias file on GitHub
ALIAS_URL="https://raw.githubusercontent.com/Donnie7/linux-alias/main/my_alias"

# Define start and end comment markers
START_COMMENT="# >>> start of my_aliases"
END_COMMENT="# >>> end of my_aliases"

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

# Check if the alias comments exist in the file
if ! grep -q "$START_COMMENT" "$DEST" || ! grep -q "$END_COMMENT" "$DEST"; then
    echo -e "\n$START_COMMENT\n$END_COMMENT" >> "$DEST"
fi

# Download new aliases to a temporary file
TMP_FILE=$(mktemp)
curl -s $ALIAS_URL -o $TMP_FILE

# Replace old aliases in the configuration file
sed -i "/$START_COMMENT/,/$END_COMMENT/{//!d}" "$DEST"  # Delete the old aliases
sed -i "/$START_COMMENT/r $TMP_FILE" "$DEST"            # Insert new aliases after start comment

# Remove temporary file
rm $TMP_FILE

echo "Aliases synced successfully."
