#!/bin/bash
# Locate the installed Dock.app and exec its bundled MCP binary.
# Falls back to the standard /Applications path if Spotlight is unavailable.

DOCK_APP=$(mdfind -onlyin /Applications "kMDItemCFBundleIdentifier == 'com.dimix.applications.dock'" 2>/dev/null | head -n 1)
if [ -z "$DOCK_APP" ]; then
  DOCK_APP=$(mdfind "kMDItemCFBundleIdentifier == 'com.dimix.applications.dock'" 2>/dev/null | head -n 1)
fi
if [ -z "$DOCK_APP" ] && [ -d "/Applications/Dock.app" ]; then
  DOCK_APP="/Applications/Dock.app"
fi

if [ -z "$DOCK_APP" ] || [ ! -x "$DOCK_APP/Contents/MacOS/DockMCP" ]; then
  echo "Dock — ASO Tracker is not installed. Install it from the Mac App Store: https://apps.apple.com/app/dock-aso-tracker" >&2
  exit 1
fi

exec "$DOCK_APP/Contents/MacOS/DockMCP" "$@"
