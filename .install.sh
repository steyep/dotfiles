#!/bin/bash
backup=$HOME/dotfiles-backup
cd $(dirname "$0")
ignore=./ignore
[ -f $ignore ] || echo ignore $'\n'README.md > $ignore

echo "Creating a backup directory for existing files"
echo 
mkdir -p $backup

for file in `ls`
do
  flag=true
  while read line
  do
    # If the file is listed in the "ignore" file, flag it as ignored
    [[ "$line" == "$file" ]] && flag=false
  done < $ignore

  if [ "$flag" == true ]; 
    then
      dest="$HOME/.$file"                     # Destination File
      [ -L $dest ] && rm $dest                # If a symlink already exists, delete it
      [ -f $dest ] && mv $dest $backup/$file  # If a file with the same name exists, back it up
      ln -sv $PWD/$file $dest                 # Create the symlink for the file      
    else
      echo "Ignoring \"$file\""
  fi
done

echo
# Remove backup folder if it's empty
if [[ ! "`ls $backup`" ]]; then
  echo "Removing empty backup folder"
  rm -rf $backup
  echo
fi 

echo Done!