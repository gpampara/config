#!/bin/bash

SELECTED=$(nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | . + ["all"] | .[]' | fzf)

if [ "$SELECTED" == "all" ]; then
    nix flake update
else
    nix flake lock --update-input "$SELECTED"
fi
