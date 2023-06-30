#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPTPATH"

# Install codemirror, rollup, and any codemirror plugins we want to use.
# Note: We don't want to put these into the packages.json because we want to fetch the latest version when we run.
echo "Installing codemirror and rollup"
npm install --no-save \
  codemirror \
  @codemirror/lang-javascript \
  @codemirror/lang-html \
  @codemirror/lang-xml \
  rollup \
  @rollup/plugin-node-resolve

# Create the rollup.
npx rollup \
  ./codemirror.mjs \
  -f esm \
  -o ../amd/src/codemirror-lazy.js \
  -p @rollup/plugin-node-resolve

# Next install js-beautify
echo "Installing js-beautify"
API_URL="https://api.github.com/repos/beautify-web/js-beautify/releases/latest"

# Get the .zip download URL
ZIP_URL=$(curl -s $API_URL | jq -r ".zipball_url")

# Download the latest release
curl -L -o latest_release.zip $ZIP_URL
# Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Extract the .zip file to the temporary directory.
unzip -q latest_release.zip -d $TEMP_DIR

# Move the js-beautify files to the correct location.
cp -v $TEMP_DIR/lib/beautify*.js ../amd/src/beautify

# Copy the License file to the correct location.
cp -v $TEMP_DIR/LICENSE ../amd/src/beautify/LICENSE

# Remove the temporary directory.
rm -rf $TEMP_DIR
