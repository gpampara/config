#!/bin/bash

function update_brave_version () {
    CURRENT_VERSION=$(nix eval --impure --raw --expr "(import ./overlay/brave/brave-version.info).version")
    CURRENT_HASH=$(nix eval --impure --raw --expr "(import ./overlay/brave/brave-version.info).sha256")
    VERSION=$(curl -sL https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-amd64/Packages | sed -r -n 's/^Version: (.*)/\1/p' | head -n1)

    echo "${CURRENT_VERSION}, ${CURRENT_HASH}, ${VERSION}"

    if [ "${CURRENT_VERSION}" != "${VERSION}" ]; then
        echo "New version of Brave found, updating metadata..."
        if [ -z "$CURRENT_HASH" ]; then
            echo "The current hash is empty - this indicates an error"
            exit 1
        else
            NEW_HASH=$(nix-prefetch-url "https://github.com/brave/brave-browser/releases/download/v${VERSION}/Brave-Browser-x64.dmg")
        fi

        echo "{ version = \"${VERSION}\"; sha256 = \"${NEW_HASH}\"; }" > ./overlay/brave/brave-version.info
    fi
}

SELECTED=$(nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | . += ["inputs", "brave"] | .[]' | fzf)

if [ -z "$SELECTED" ]; then
    exit 1;
elif [ "$SELECTED" == "inputs" ]; then
    update_brave_version && nix flake update
elif [ "$SELECTED" == "brave" ]; then
    update_brave_version
else
    nix flake lock --update-input "$SELECTED"
fi
