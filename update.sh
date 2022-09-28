#!/bin/bash

function update_brave_version () {
    CURRENT_HASH=$(nix eval --impure --raw --expr "(import ./overlays/brave/brave-version.info).sha256")
    VERSION=$(curl -sL https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-amd64/Packages | sed -r -n 's/^Version: (.*)/\1/p' | head -n1)
    HASH=$(nix-prefetch-url "https://github.com/brave/brave-browser/releases/download/v${VERSION}/Brave-Browser-x64.dmg" "${CURRENT_HASH}" --type sha256 2>/dev/null)
    echo "{ version = \"${VERSION}\"; sha256 = \"${HASH}\"; }" > ./overlays/brave/brave-version.info
}

SELECTED=$(nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | . + ["all", "brave"] | .[]' | fzf)

if [ -z "$SELECTED" ]; then
    exit 1;
elif [ "$SELECTED" == "all" ]; then
    update_brave_version
    nix flake update
elif [ "$SELECTED" == "brave" ]; then
    update_brave_version
else
    nix flake lock --update-input "$SELECTED"
fi
