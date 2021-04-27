#! /bin/sh

if hash code &> /dev/null; then
  src_directory="$PWD/$(dirname $BASH_SOURCE | sed s_${PWD}/__)"
  extensions_list="$src_directory/vscode--extensions.txt"
  test -f $extensions_list || exit 0
  while read extension; do
    code --install-extension $extension
  done < $extensions_list
fi
