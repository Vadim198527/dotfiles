#!/usr/bin/env zsh
target_dir=${1:-.}

for file in "$target_dir"/*; do
  if [[ -f $file && $file != *.tt ]]; then
    mv -- "$file" "${file}.tt"
  fi
done
