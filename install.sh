#!/bin/bash
backup=$HOME/dotfiles-backup
cd $(dirname "$0")

echo "Creating a backup directory for existing files"
echo
mkdir -p $backup

for file in $(find $PWD -name '*.symlink'); do
  dest="$HOME/$(basename "${file%*.symlink}")"
  test -L "$dest" && rm "$dest"                                # If a symlink already exists, delete it
  test -f "$dest" && mv "$dest" "$backup/$(basename "$file")"  # If a file with the same name exists, back it up
  ln -sv "$file" "$dest"                                       # Create the symlink for the file
done

# Remove backup folder if it's empty
if [[ ! "$(ls -A $backup)" ]]; then
  echo "Removing empty backup folder"
  rm -rf $backup
  echo
fi

echo "Done!"