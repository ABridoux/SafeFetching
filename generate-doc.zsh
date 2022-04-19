#!/bin/zsh

# Constants

directory="${0:a:h}/docs"
 
# Command

swift package --allow-writing-to-directory $directory \
generate-documentation --target SafeFetching \
--disable-indexing \
--transform-for-static-hosting \
--hosting-base-path SafeFetching \
--output-path $directory