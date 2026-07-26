#!/usr/bin/env bash
kaomoji=$(fuzzel -d --config ~/.local/bin/fuzzel-kaomoji/fuzzel.ini --with-nth 2 --match-nth 1 <~/.local/bin/fuzzel-kaomoji/kaomoji.tsv)
echo "$kaomoji" | awk -F'\t' '{print $2}' | wl-copy -n
wtype -M ctrl v -m ctrl
