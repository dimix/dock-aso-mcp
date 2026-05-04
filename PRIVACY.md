# Privacy Policy — Dock ASO MCP Extension

_Last updated: 2026-04-29_

This document describes how the **Dock — ASO Tracker MCP extension** handles your data. It is a companion to the privacy policy of the [Dock macOS app](https://dock-app.com) — the extension is a thin bridge to that app and inherits its data handling for everything except the MCP transport layer described below.

## Who we are

The Dock MCP extension is published by **Dimitri Giani** (Italy). Contact: <info@dock-app.com>.

## What the extension is

The Dock MCP extension is a desktop extension (`.mcpb`) for Claude Desktop and other MCP-compatible clients. It packages a small stdio bridge (`DockMCP`) that translates MCP tool calls into HTTP requests sent to the Dock macOS app running on the same machine, on `http://localhost:8765`.

The extension does **not** open any network connections to the public internet. It does not include analytics, telemetry, crash reporting, or any third-party SDK.

## What data is processed

When you invoke a Dock MCP tool from Claude:

1. Claude sends the tool name and the arguments you (or it) supplied to the extension's stdio.
2. The extension forwards the call to the Dock app on `localhost`.
3. The Dock app reads from its local store (Core Data) and, when needed, calls the relevant store API (App Store Connect, Google Play Developer API) using credentials you configured inside Dock.
4. The response is returned to Claude through the same stdio channel.

The data that flows through the MCP boundary is therefore the same data that you can already see inside the Dock app: localized listings (title, subtitle, descriptions, keywords, what's new, promotional text), screenshots, reviews, sales and finance summaries, and metadata about your apps. **No additional data category is collected by the extension itself.**

## Credentials

App Store Connect API keys and Google Play OAuth tokens are stored and used exclusively by the Dock app on your Mac (Keychain / Core Data). They are **never transmitted through the MCP extension**. The extension cannot read or export your credentials.

## What is shared with Claude

Anything returned by a tool call is sent back to Claude as part of the MCP response and is therefore visible to the LLM. This may include your localized store metadata, keyword data, user reviews, sales figures, and other content you manage with Dock. Anthropic's privacy policy governs how Claude processes that content; please review it at <https://www.anthropic.com/privacy>.

You can mitigate exposure by:

- Only enabling the MCP server in Dock when needed.
- Picking the apps, languages, and time periods you ask Claude about.
- Reviewing the destructive-hint confirmation that Claude Desktop surfaces before any `update_*` call.

## Write operations

Two tools modify state: `update_app_aso_content` and `update_google_app_aso_content`. Both are annotated with `destructiveHint: true`, which Claude Desktop renders as an explicit user-confirmation prompt. Edits are saved as **local drafts** inside the Dock app — they are not pushed to App Store Connect or Google Play until you publish them yourself from Dock's UI.

## Logging

The extension writes diagnostic messages to standard error (stderr), which Claude Desktop captures into its local extension logs. These logs include the tool name and the URL of the local HTTP request (`http://localhost:8765/...`) but never include credentials or argument values. The logs stay on your Mac.

## Children

The extension is intended for professional use by app developers and is not directed at children under 16.

## Changes to this policy

If we materially change how the extension handles data, the new policy will be published at <https://dock-app.com/privacy-policy/> with an updated "Last updated" date. The extension itself does not check for policy updates; you can review the latest version any time at the link above.

## Contact

For privacy questions specific to the MCP extension, contact <info@dock-app.com>. For privacy questions about the Dock macOS app, see the app's main privacy policy at <https://dock-app.com/privacy-policy/>.
