#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPTPATH"

# Install codemirror, rollup, and any codemirror plugins we want to use.
# Note: We don't want to put these into the packages.json because we want to fetch the latest version when we run.
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
  -o ../amd/src/codemirror.js \
  -p @rollup/plugin-node-resolve
