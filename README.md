# Dock — ASO Tracker · Desktop Extension for Claude

> **This repository is archived.** The extension now ships inside the Dock app, always matching the version you have installed. To install it, open **Dock → Settings → MCP** and click **Install Claude Desktop extension**.

[Dock — ASO Tracker](https://dock-app.com) is a native macOS app for App Store Connect and Google Play Console workflows. Its Claude Desktop extension connects Claude to the data Dock manages on your Mac: listings, screenshots and the Asset Library, keyword and competitor research, reviews, sales, finance and invoicing, and the app's website.

This repository held the extension's manifest and launcher while it was distributed separately. Its last release here, v1.4.0, carries 15 tools; the extension inside Dock 4.1 carries 34. The bundle from Dock's Settings is the one to use: it is rebuilt with every Dock release, and this repository no longer is.

## How the extension works

```
Claude Desktop ──stdio──▶ launcher.sh ──exec──▶ DockMCP (inside Dock.app) ──HTTP──▶ Dock.app (127.0.0.1:8765)
```

The launcher finds the installed Dock app through Spotlight and executes the `DockMCP` binary inside it, which forwards each tool call to Dock's local server. That server is bound to the loopback interface only and refuses requests from web pages. Store credentials stay in Dock's keychain and never cross the MCP boundary.

## Documentation and privacy

- Documentation: [dock-app.com/mcp-docs](https://dock-app.com/mcp-docs/)
- Privacy policy, including a section on the extension: [dock-app.com/privacy-policy](https://dock-app.com/privacy-policy/)
- Contact: <info@dock-app.com>

## License

The launcher script, manifest, and build script in this repository are provided under the [MIT License](LICENSE) so you can audit, fork, and adapt the integration.

The Dock — ASO Tracker macOS app (which contains the actual MCP server binary) and the icon assets in this repository are proprietary and **not** covered by the MIT grant. All rights reserved.
