#!/bin/bash

nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | .[]' | fzf | xargs nix flake lock --update-input
