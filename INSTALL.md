# Installing DevSessions

DevSessions is a macOS menu bar app and widget for resuming recent OpenCode, Claude Code, Codex, Pi, and Oh My Pi sessions.

## Requirements

- macOS 14 Sonoma or later.
- Apple Silicon or Intel Mac.
- No Apple ID, developer account, Xcode, or Terminal setup is needed to install the DMG.
- Terminal.app is the default terminal. Ghostty is optional.

## Download

- Latest release: <https://github.com/prashanthgit19/devsessions/releases/latest>
- Download both `DevSessions-0.1.1.dmg` and `SHA256SUMS`.

Public builds are signed with the project’s free **Apple Development** certificate. They are not notarized, so macOS asks for a one-time approval.

Do not use the ad-hoc test DMG produced by the CI workflow for a normal install. Ad-hoc apps cannot write the shared App Group on another Mac, so the cache and widget fail there.

## Verify the download

Put the DMG and `SHA256SUMS` in the same folder, then run:

```sh
cd ~/Downloads
shasum -a 256 -c SHA256SUMS
```

You should see:

```text
DevSessions-0.1.1.dmg: OK
```

## Install

1. Open the DMG.
2. Drag **DevSessions.app** to **Applications**.
3. Eject the DMG.
4. Open DevSessions from Applications.

## First launch

macOS blocks the first launch because the app is not notarized:

1. Try to open DevSessions. macOS reports that it cannot verify the app.
2. Open **System Settings → Privacy & Security**.
3. Scroll to **Security**, click **Open Anyway**, authenticate, then click **Open**.

If macOS says the app is damaged, remove the quarantine flag and open it again:

```sh
xattr -dr com.apple.quarantine /Applications/DevSessions.app
```

This approval is one-time. Users do not need an Apple ID or developer account.

## First run

1. The ring-and-dot **DevSessions** icon appears in the menu bar.
2. Choose **Open Sessions** to see recent sessions.
3. Add the widget: right-click the desktop → **Edit Widgets** → **DevSessions**. Choose small, medium, or large.
4. In **Settings → General**, set the activity window and optionally enable **Launch at login**.
5. In **Settings → Terminal**, choose **Terminal** or **Ghostty**, then click **Test Terminal**.
   - Ghostty opens a new window in the running instance. macOS asks once for Automation approval.
   - If it was denied: **System Settings → Privacy & Security → Automation → DevSessions**, then enable Ghostty.
6. In **Settings → Widget**, choose **Match System**, **Midnight**, **Paper**, **Graphite**, or **Coast**.
   - App themes apply in **Full Color**.
   - **Clear** and **Tinted** are system-wide styles in **System Settings → Appearance**. macOS replaces the theme background with its glass treatment.
7. In **Settings → Agents**, use **Refresh Now** and check the detected-agent diagnostics.

## Resume a session

- Click a session row in the widget or in **Open Sessions**.
- DevSessions opens the selected terminal in the project directory and runs that agent’s resume command.
- The widget always deep-links back to DevSessions first.

## Troubleshooting

### “You don’t have permission to save the file ‘DevSessions’ in the folder ‘67Z29VG25Z.com.devsessions.shared2’”

This is the ad-hoc signing limitation from 0.1.0 or a CI test build. Ad-hoc apps cannot write an App Group container on another Mac.

Use the team-signed **0.1.1** DMG. If you previously installed 0.1.0, clear the stale container first:

```sh
pkill -x DevSessions
rm -rf ~/Library/Group\ Containers/67Z29VG25Z.com.devsessions.shared2
```

Then install and open 0.1.1. The app recreates the cache.

### The widget does not refresh

- Click **Settings → Agents → Refresh Now** and wait a few seconds. macOS can throttle widget reloads.
- If it is still stale, remove the widget and add it again.
- 0.1.1 reloads the widget after every scan.

### The menu bar icon is missing

Use 0.1.1 or later. 0.1.0 had an invisible custom menu bar label.

### Ghostty does not open

- Choose **Settings → Terminal → Test Terminal**, then approve Automation.
- If it was denied: **System Settings → Privacy & Security → Automation → DevSessions**, then enable Ghostty.
- Ghostty must be installed in `/Applications`.

### DevSessions cannot find an agent CLI

DevSessions resolves agent CLIs from the login shell PATH. Confirm the CLI works in Terminal; the resolved paths and diagnostics are shown in **Settings → Agents**.

### The widget is white or blank

Remove and re-add the widget once. If it persists, report your macOS version and widget size.

### Login item

Launch at login is off by default. Enable it in **Settings → General**; if macOS asks, approve DevSessions in **System Settings → General → Login Items**.

## Build from source

```sh
brew install xcodegen
git clone https://github.com/prashanthgit19/devsessions.git
cd devsessions
make project
open DevSessions.xcodeproj
```

In Xcode, select your team for both the **DevSessions** and **DevSessionsWidget** targets. The App Group follows `APP_GROUP_ID`, which defaults to:

```text
$(TeamIdentifierPrefix)com.devsessions.shared2
```

If you need a different team, change only `DEVELOPMENT_TEAM` in `project.yml`, then run `make project` again. The App Group follows the signing team automatically.

Useful commands:

```sh
make verify     # core checks, plist lint, Swift type checks
make release    # Apple Development-signed DMG in dist/
```

`DEVELOPER_ID_APPLICATION="-" make release` produces an ad-hoc CI/UI test DMG. It cannot write the shared App Group on another Mac, so do not publish it.

## Signing

The current public DMG is signed with a free **Apple Development** certificate and is not notarized. Gatekeeper approval is required, and the certificate expires yearly.

Developer ID signing and notarization are the frictionless public path and require the paid Apple Developer Program. Until then, the Apple Development-signed DMG is the free public build.

## Links

- Releases: <https://github.com/prashanthgit19/devsessions/releases>
- Source: <https://github.com/prashanthgit19/devsessions>
- Privacy: [PRIVACY.md](PRIVACY.md)
- License: [LICENSE](LICENSE)
