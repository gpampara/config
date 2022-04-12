#!/bin/bash

function update_brave_version () {
    VERSION=$(curl https://api.github.com/repos/brave/brave-browser/releases 2>/dev/null | jq -r 'map(select(.draft == false and .prerelease == false and select(.name | startswith("Release")))) | .[0].tag_name | sub("^v"; "")')
    echo "{ version = \"$VERSION\"; }" > ./overlays/brave/brave-version.info
}

SELECTED=$(nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | . + ["all", "brave"] | .[]' | fzf)

if [ -z "$SELECTED" ]; then
    exit 1;
elif [ "$SELECTED" == "all" ]; then
    nix flake  update
elif [ "$SELECTED" == "brave" ]; then
    update_brave_version
else
    nix flake lock --update-input "$SELECTED"
fi
