#!/bin/bash

SELECTED=$(nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | . + ["all"] | .[]' | fzf)

if [ -z "$SELECTED" ]; then
    exit 1;
elif [ "$SELECTED" == "all" ]; then
    nix flake update
else
    nix flake lock --update-input "$SELECTED"
fi
