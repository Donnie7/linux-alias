#!/bin/zsh

# Path to the file containing the list of aliases (File A)
ALIAS_FILE="../my_alias"

# Define start and end comment markers
START_COMMENT="# >>> start of my_aliases"
END_COMMENT="# >>> end of my_aliases"

# Use $SHELL to determine the shell and set the destination file
case "$SHELL" in
    *zsh)
        # Assume Zsh
        DEST="$HOME/.zshrc"
        ;;
    *bash)
        # Assume Bash
        DEST="$HOME/.bashrc"
        ;;
    *)
        # Default to Bash, but this might be adjusted as needed
        DEST="$HOME/.bashrc"
        echo "Unknown shell, defaulting to .bashrc"
        ;;
esac

# Check if the alias comments exist in the file
if ! grep -q "$START_COMMENT" "$DEST" || ! grep -q "$END_COMMENT" "$DEST"; then
    echo -e "\n$START_COMMENT\n$END_COMMENT" >> "$DEST"
fi

# Verify if ALIAS_FILE exists
if [ ! -f "$ALIAS_FILE" ]; then
    echo "Alias file not found: $ALIAS_FILE"
    exit 1
fi

echo "Reading aliases from $ALIAS_FILE"

# Replace old aliases in the configuration file
sed -i "/$START_COMMENT/,/$END_COMMENT/{//!d}" "$DEST"  # Delete the old aliases
sed -i "/$START_COMMENT/r $ALIAS_FILE" "$DEST"         # Insert new aliases after start comment

source ~/.zshrc

echo "Aliases synced successfully."
