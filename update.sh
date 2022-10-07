#!/bin/bash

function update_brave_version () {
    CURRENT_VERSION=$(nix eval --impure --raw --expr "(import ./overlays/brave/brave-version.info).version")
    CURRENT_HASH=$(nix eval --impure --raw --expr "(import ./overlays/brave/brave-version.info).sha256")
    VERSION=$(curl -sL https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-amd64/Packages | sed -r -n 's/^Version: (.*)/\1/p' | head -n1)

    if [ "${CURRENT_VERSION}" != "${VERSION}" ]; then
        echo "New version of Brave found, updating metadata..."
        STORE_PATH=$(nix-prefetch-url --print-path "https://github.com/brave/brave-browser/releases/download/v${VERSION}/Brave-Browser-x64.dmg" "${CURRENT_HASH}")
        NEW_HASH=$(echo "${STORE_PATH}" | head -n 1)
        echo "{ version = \"${VERSION}\"; sha256 = \"${NEW_HASH}\"; }" > ./overlays/brave/brave-version.info
    fi
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
