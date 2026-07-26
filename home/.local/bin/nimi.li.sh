#! /usr/bin/env bash
cd "$HOME/git/nimi.li/" || exit
pnpm run dev &
sleep 2
firefox "http://localhost:5173/"
