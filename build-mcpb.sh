#!/bin/bash
# Build dock-aso-<version>.mcpb from this repository's contents.
# Requires Node.js (for npx).

set -euo pipefail
cd "$(dirname "$0")"

VERSION=$(node -p "require('./manifest.json').version" 2>/dev/null || \
          /usr/bin/python3 -c 'import json; print(json.load(open("manifest.json"))["version"])')

OUTPUT="dock-aso-${VERSION}.mcpb"
chmod +x server/dock-mcp-launcher.sh

npx -y @anthropic-ai/mcpb validate manifest.json
npx -y @anthropic-ai/mcpb pack . "$OUTPUT"

echo
echo "Built: $(pwd)/$OUTPUT"
