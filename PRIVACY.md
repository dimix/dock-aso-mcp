# Privacy Policy — Dock ASO MCP Extension

_Last updated: 2026-10-09_

This document describes how the **Dock — ASO Tracker MCP extension** handles your data. It mirrors the extension section of the [Dock privacy policy](https://dock-app.com/privacy-policy/), which is the authoritative version. The extension is a thin bridge to the Dock macOS app and inherits its data handling for everything except the MCP transport layer described below.

## Who we are

The Dock MCP extension is published by **dimix.it di Dimitri Giani** (Italy). Contact: <info@dock-app.com>.

## What the extension is

The Dock MCP extension is a desktop extension (`.mcpb`) for Claude Desktop and other MCP-compatible clients. It packages a small stdio bridge (`DockMCP`) that translates MCP tool calls into HTTP requests sent to the Dock macOS app running on the same machine, at `http://127.0.0.1:8765`.

The extension **does not open any network connections to the public internet**. It contains no analytics, no telemetry, no crash reporting and no third-party SDK.

## What data is processed

When you invoke one of the extension's 34 tools from Claude:

1. Claude sends the tool name and its arguments to the extension over stdio.
2. The extension forwards the call to the Dock app on your machine.
3. Dock reads from its local database and, when needed, calls the relevant API (App Store Connect, Google Play, or Google Search Console for the Web Presence keyword research tool) using the credentials you configured inside Dock.
4. The response travels back to Claude through the same stdio channel.

The data crossing the MCP boundary is therefore the same data you can already see inside Dock: localized listings, screenshots, app previews (their status, a link to the video and a still frame), the contents of your App Store Connect Asset Library and your product page's creative assets, keyword and ranking analysis, app evolution history, public App Intelligence research on other apps in the store, user reviews, sales and finance summaries, how a month's App Store proceeds split across the Apple companies that paid them, metadata about your apps and their twins, and — through the Web Presence tools — your site's technical audit, the search phrases you are researching together with their Search Console impressions, your positions on Google for the keywords you follow, and the list of third-party pages worth asking for a link.

That last one deserves naming plainly: a link building target carries the **address, title and public contact email address of a page belonging to somebody else**, read from that page when it was checked or recorded by you. Those addresses reach the model along with the rest of the answer.

**No additional data category is collected by the extension itself.**

## Credentials

App Store Connect API keys and Google OAuth tokens are stored and used exclusively by the Dock app on your Mac, in the macOS keychain. They are **never transmitted through the MCP extension**, and the extension cannot read or export them.

## What is shared with Claude

Anything a tool returns is sent back to Claude as part of the MCP response, and is therefore visible to the model. This may include your localized store metadata, keyword data, user reviews, sales figures and other content you manage with Dock. How Claude processes that content is governed by Anthropic's privacy policy: <https://www.anthropic.com/privacy>. If you use a different MCP client, that client's own policy applies instead.

You can limit what is exposed by:

- enabling the MCP server in Dock only while you are using it;
- choosing which apps, languages and time periods you ask Claude about;
- reviewing the confirmation prompt your MCP client shows before any `update_*` call.

## The local server

Dock's MCP server runs inside the Dock app and listens on TCP port 8765 for as long as you leave it enabled in Settings. It is bound to the **loopback interface only**, so it is not reachable from your local network or from the internet: only software running on your own Mac can connect to it, and requests coming from a web page are refused.

## Write operations

Five of the thirty-four tools change something, and they fall into two groups.

`update_app_aso_content` and `update_google_app_aso_content` edit your store listings. Both are annotated `destructiveHint: true`, which Claude Desktop renders as an explicit confirmation prompt. Edits are saved as **local drafts** inside Dock. They are not pushed to App Store Connect or Google Play until you publish them yourself from Dock's interface.

`add_research_keywords`, `follow_keywords` and `update_link_building_target` only add to lists inside Dock — a phrase to research, a keyword to track, a note about a page you wrote to. Nothing is overwritten, so they are annotated `destructiveHint: false` and your client may not prompt for them.

None of the five spends money on your behalf, and **no tool sends email**. Search data is bought with your own DataForSEO key, from inside Dock, where the price is on screen: the tools report what something *would* cost and leave the decision with you. Following a keyword is free in itself, but a followed keyword is read on a schedule, so it does commit future spending — bounded by the monthly ceiling you set in Dock's Settings › Web Data, which the updater stops at.

The nine Web Presence tools and the two Invoicing tools require an active Dock subscription; the other twenty-three do not.

## Logging

The extension writes diagnostic messages to standard error, which your MCP client captures into its local extension logs. Each one is the address of a local request (`http://127.0.0.1:8765/mcp/...`), and that address names what was asked for — an app's bundle id, a language, a keyword, a month. They **never** include credentials, and never the content of an edit: request bodies are not logged. The logs stay on your Mac.

## Children

The extension is intended for professional use by app developers and is not directed at anyone under 16.

## Changes to this policy

If we materially change how the extension handles data, the updated policy will be published at <https://dock-app.com/privacy-policy/> with a new "Last updated" date. The extension itself does not check for policy updates; you can review the latest version at the link above at any time.

## Contact

For privacy questions specific to the MCP extension, contact <info@dock-app.com>. For privacy questions about the Dock macOS app, see the app's main privacy policy at <https://dock-app.com/privacy-policy/>.
