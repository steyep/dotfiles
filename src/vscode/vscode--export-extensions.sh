#! /bin/sh

if hash code &> /dev/null; then
  src_directory="$PWD/$(dirname $BASH_SOURCE | sed s_${PWD}/__)"
  extensions_list="$src_directory/vscode--extensions.txt"
  code --list-extensions --show-versions > $extensions_list
fi
