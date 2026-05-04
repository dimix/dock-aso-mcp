# Dock — ASO Tracker · Desktop Extension for Claude

A Claude Desktop extension that connects Claude to **[Dock — ASO Tracker](https://dock-app.com)**, a native macOS app for App Store Connect and Google Play Console workflows.

The extension exposes 15 MCP tools so Claude can read and edit your localized listings, run keyword and screenshot analysis, browse user reviews, and inspect sales and finance data — all using the data already managed locally by the Dock app.

> This repository is a **companion** to the closed-source Dock macOS app. It contains the manifest, launcher script, and assets that make up the `.mcpb` desktop extension. The actual MCP server binary ships inside the Dock app bundle.

## Architecture

```
Claude Desktop ──stdio──▶ launcher.sh ──exec──▶ DockMCP (inside Dock.app) ──HTTP──▶ Dock.app (localhost:8765)
```

The extension is a thin bridge:

1. Claude Desktop launches `server/dock-mcp-launcher.sh` over stdio.
2. The launcher locates the installed Dock app via Spotlight (`mdfind kMDItemCFBundleIdentifier == 'com.dimix.applications.dock'`).
3. It `exec`s the `DockMCP` Swift binary bundled inside the app, which speaks JSON-RPC 2.0 on stdin/stdout.
4. `DockMCP` forwards each tool call as an HTTP request to the Dock app's local server on `localhost:8765`.

No data leaves your Mac. The launcher does not initiate any network connection itself.

## Requirements

- **macOS** (the Dock app is macOS-only).
- **Dock — ASO Tracker** installed from the [Mac App Store](https://dock-app.com) and running, with the local MCP server enabled in **Settings → MCP**.
- **Claude Desktop** (the native app for macOS or Windows).

## Installation

### From the Connectors Directory (recommended)

Open Claude Desktop → **Settings → Connectors → Browse connectors**, then search for *Dock*.

### Manually from a release

1. Grab the latest `dock-aso-<version>.mcpb` from the [Releases](../../releases) page.
2. Open Claude Desktop → **Settings → Extensions** and drag the `.mcpb` file onto the window, or double-click it.
3. Make sure the Dock app is running with the MCP server enabled.

## Tools

All read tools carry the `readOnlyHint`. The two `update_*` tools carry the `destructiveHint`, so Claude Desktop surfaces a user-confirmation prompt before each call.

### Apple App Store
| Tool | Hint | Purpose |
| --- | --- | --- |
| `get_apps_and_languages` | read-only | List Apple apps configured in Dock and their languages. |
| `get_app_keywords_analysis` | read-only | Detailed keyword analysis (popularity, difficulty, opportunity index). |
| `get_app_aso_content` | read-only | Read title, subtitle, keywords, description, promotional text, what's new. |
| `update_app_aso_content` | destructive | Save edits as a local draft inside Dock (publish from the app). |
| `get_app_screenshots` | read-only | Fetch App Store screenshots (returns images for visual analysis). |

### Google Play
| Tool | Hint | Purpose |
| --- | --- | --- |
| `get_google_apps_and_languages` | read-only | List Google Play apps configured in Dock. |
| `get_google_app_aso_content` | read-only | Read listing content + ASO score breakdown. |
| `update_google_app_aso_content` | destructive | Save edits as a local draft inside Dock (publish from the app). |

### Reviews
| Tool | Hint | Purpose |
| --- | --- | --- |
| `get_app_reviews` | read-only | Apple App Store reviews with summary statistics. |
| `get_google_app_reviews` | read-only | Google Play reviews with summary statistics. |

### Sales & Finance
| Tool | Hint | Purpose |
| --- | --- | --- |
| `get_sales_summary` | read-only | Sales summary across all apps (month or year). |
| `get_finance_summary` | read-only | Monthly financial report (proceeds, partner share, commissions). |
| `get_finance_year` | read-only | Yearly financial summary (fiscal or calendar). |

### Cross-platform
| Tool | Hint | Purpose |
| --- | --- | --- |
| `get_twin_apps` | read-only | List linked Apple ↔ Google twin apps. |
| `get_twin_comparison` | read-only | Side-by-side comparison of an Apple app and its Google twin. |

## Configuration

The extension accepts one optional `user_config` value:

- `dock_port` — the port used by the Dock app's local MCP HTTP server. Defaults to `8765`. Must match the port configured in **Dock → Settings → MCP**.

## Building the `.mcpb` locally

```bash
./build-mcpb.sh
```

The script validates `manifest.json` and packs the bundle using the official [`@anthropic-ai/mcpb`](https://www.npmjs.com/package/@anthropic-ai/mcpb) CLI. Output: `dock-aso-<version>.mcpb`.

Requires Node.js (for `npx`).

## Privacy

See [PRIVACY.md](PRIVACY.md). The short version: the extension itself never opens a network connection beyond `localhost`. All store credentials stay inside the Dock app's keychain and are never transmitted through the MCP boundary.

## Support

- App: [dock-app.com](https://dock-app.com)
- Documentation: [dock-app.com/mcp-docs](https://dock-app.com/mcp-docs/)
- Email: <info@dock-app.com>

## License

The launcher script, manifest, and build script in this repository are provided under the [MIT License](LICENSE) so you can audit, fork, and adapt the integration.

The Dock — ASO Tracker macOS app (which contains the actual MCP server binary) and the icon assets in this repository are proprietary and **not** covered by the MIT grant. All rights reserved.
