#!/bin/bash

# Define the URL to your raw alias file on GitHub
ALIAS_URL="https://raw.githubusercontent.com/yourusername/linux-aliases/main/my_aliases"

# Determine the shell and set the destination file
if [ -n "$ZSH_VERSION" ]; then
    # Assume Zsh
    DEST="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    # Assume Bash
    DEST="$HOME/.bashrc"
else
    # Try to determine the shell from $SHELL variable
    case $SHELL in
        */zsh)
            # Assume Zsh
            DEST="$HOME/.zshrc"
            ;;
        */bash)
            # Assume Bash
            DEST="$HOME/.bashrc"
            ;;
        *)
            # Unknown shell, default to Bash
            DEST="$HOME/.bashrc"
            echo "Unknown shell, defaulting to .bashrc"
            ;;
    esac
fi

# Check if the alias comments exist in the file
if ! grep -q "# >>> start of my_aliases" "$DEST" || ! grep -q "# >>> end of my_aliases" "$DEST"; then
    echo -e "\n# >>> start of my_aliases\n# >>> end of my_aliases" >> "$DEST"
fi

# Download new aliases to a temporary file
TMP_FILE=$(mktemp)
curl -s $ALIAS_URL -o $TMP_FILE

# Replace old aliases in the configuration file
sed -i '/# >>> start of my_aliases/,/# >>> end of my_aliases/{//!d}' "$DEST"
sed -i "/# >>> end of my_aliases/ r $TMP_FILE" "$DEST"

# Remove temporary file
rm $TMP_FILE

echo "Aliases synced successfully."
