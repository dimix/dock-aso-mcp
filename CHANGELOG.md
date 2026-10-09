# Changelog

All notable changes to the Dock — ASO Tracker MCP extension are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Archived — 2026-10-09

The extension is now distributed inside the Dock app (Settings → MCP → Install Claude Desktop extension), rebuilt with every Dock release, and this repository is no longer updated. `manifest.json` and `PRIVACY.md` are left as they stand in Dock 4.1 (extension 2.1.0, 34 tools); no 2.1.0 release is published here.

## [1.4.0] — 2026-05-04

Initial public release of the Desktop Extension.

### Added
- 15 MCP tools covering Apple App Store, Google Play, reviews, sales, finance, and cross-platform twin apps.
- Stdio launcher (`server/dock-mcp-launcher.sh`) that locates the installed Dock app via Spotlight and execs the bundled `DockMCP` binary.
- `readOnlyHint` / `destructiveHint` annotations on all tools.
- Manifest conforming to MCPB spec v0.3.
- `dock_port` user_config for non-default Dock MCP ports.
