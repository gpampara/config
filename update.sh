#!/bin/bash

function update_brave_version () {
    CURRENT_VERSION=$(nix eval --impure --raw --expr "(import ./overlays/brave/brave-version.info).version")
    CURRENT_HASH=$(nix eval --impure --raw --expr "(import ./overlays/brave/brave-version.info).sha256")
    VERSION=$(curl -sL https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-amd64/Packages | sed -r -n 's/^Version: (.*)/\1/p' | head -n1)

    echo "${CURRENT_VERSION}, ${CURRENT_HASH}, ${VERSION}"

    if [ "${CURRENT_VERSION}" != "${VERSION}" ]; then
        echo "New version of Brave found, updating metadata..."
        if [ -z "$CURRENT_HASH" ]; then
            NEW_HASH=$(nix-prefetch-url "https://github.com/brave/brave-browser/releases/download/v${VERSION}/Brave-Browser-x64.dmg")
        else
            NEW_HASH=$(nix-prefetch-url "https://github.com/brave/brave-browser/releases/download/v${VERSION}/Brave-Browser-x64.dmg" "${CURRENT_HASH}")
        fi

        echo "{ version = \"${VERSION}\"; sha256 = \"${NEW_HASH}\"; }" > ./overlays/brave/brave-version.info
    fi
}

function update_kitty () {
    CURRENT_VERSION=$(nix eval --impure --raw --expr "(import ./overlays/kitty/kitty-version.info).version")
    CURRENT_HASH=$(nix eval --impure --raw --expr "(import ./overlays/kitty/kitty-version.info).sha256")
    LATEST=$(curl -s https://api.github.com/repos/kovidgoyal/kitty/releases/latest | jq -r '.assets[] | select(.name|match(".dmg$")) | .browser_download_url')
    VERSION=$(echo "$LATEST" | grep -Eo '[0-9]\.[0-9]+\.[0-9]+' | head -n 1)

    # Try prefetch because it's a noop if already exists
    if [ -z "$CURRENT_HASH" ]; then
        NEW_HASH=$(nix-prefetch-url "$LATEST")
    else
        NEW_HASH=$(nix-prefetch-url "$LATEST" "$CURRENT_HASH")
    fi
    echo "{ version = \"${VERSION}\"; sha256 = \"${NEW_HASH}\"; }" > ./overlays/kitty/kitty-version.info
}

SELECTED=$(nix flake metadata --json --quiet | jq -r '.locks.nodes.root.inputs | keys | . + ["all", "brave"] | .[]' | fzf)

if [ -z "$SELECTED" ]; then
    exit 1;
elif [ "$SELECTED" == "all" ]; then
    update_brave_version
#    update_kitty
    nix flake update
elif [ "$SELECTED" == "brave" ]; then
    update_brave_version
else
    nix flake lock --update-input "$SELECTED"
fi
