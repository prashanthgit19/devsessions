# DevSessions demo video — free production plan

**Goal:** a 15-second silent demo that makes the product obvious: click a session in the widget, terminal opens in the project, conversation resumes.

**Deliverables**

- `demo-15s.mp4` — 1920×1080, 30 or 60 fps, H.264. For X, Reddit, Product Hunt, landing page.
- `demo-8s.gif` — ~1200 px wide, 12–15 fps, under 8 MB. For README and GitHub release notes.
- `install-30s.mp4` — the Gatekeeper “Open Anyway” walkthrough. For the download page and release notes.
- 6 screenshots + 1 OG image (1280×640).

**Total cost: $0.** Everything below uses built-in macOS apps or free open-source tools. The only paid item in the whole launch is Apple notarization ($99/year), which is optional.

---

## 1. Free toolchain

| Job | Tool | Cost |
|---|---|---|
| Screen recording | QuickTime Player or `Cmd+Shift+5` | Built in |
| Editing / captions / end card | iMovie | Built in |
| End card / OG image | Keynote | Built in |
| GIF conversion | FFmpeg (`brew install ffmpeg`) | Free |
| Screenshots | `Cmd+Shift+4`, `screencapture` | Built in |
| Landing page | GitHub Pages | Free |
| Hosting video | GitHub Release asset / GitHub Pages | Free |
| Design | Keynote, Figma free tier, Canva free | Free |

Do **not** buy Screen Studio, CleanShot X, Mouseposé, or Canva Pro. They are not needed for this demo.

---

## 2. Pre-production (90 minutes)

1. **Create three safe demo projects.**
   - `~/Projects/acme-api`
   - `~/Projects/checkout`
   - `~/Projects/landing-page`

2. **Create one short session in each agent** with non-sensitive titles:
   - Claude Code: “Add rate limiting to the public API”
   - Codex: “Fix the checkout total rounding bug”
   - OpenCode: “Rewrite the landing page hero copy”

   Send one small message in each so the session exists and can be resumed. Keep them short so the agent opens fast.

3. **Configure the widget.**
   - Large size, placed on the right side of the desktop.
   - Theme: Midnight (matches the app icon) or Match System.
   - Activity window: 7 days.
   - Confirm the rows show **different agents**. If OpenCode dominates, temporarily use the 30-day window or create fresh sessions in Claude/Codex.

4. **Clean the stage.**
   - Enable Do Not Disturb.
   - Quit Slack, Discord, Mail, and anything that can notify.
   - Hide desktop icons and the Dock (`Cmd+Opt+D`).
   - Use a plain dark wallpaper.
   - Set Terminal/Ghostty to a clean profile: 16–18 pt font, dark background, no tabs if possible.

5. **Pre-warm the agents** so the resume is not a cold start:
   ```sh
   claude --version
   codex --version
   opencode --version
   ```
   Clear terminal scrollback before recording.

6. **Rehearse the clicks twice.** Move the cursor slowly, pause ~0.5 s before clicking, and pause ~1 s after the terminal opens.

---

## 3. The 15-second script

| Time | Visual | Caption |
|---|---|---|
| 0:00–0:02 | Clean desktop. Widget visible with three sessions from different agents. Menu bar shows the DevSessions ring icon. | “Your AI coding sessions, on your desktop.” |
| 0:02–0:04 | Cursor moves to the first row. The row highlights; the circular arrow is visible. | “Pick one.” |
| 0:04–0:05 | Click. | — |
| 0:05–0:09 | Terminal opens in the project directory, runs the resume command, and the conversation appears. | “It resumes in the original project.” |
| 0:09–0:10 | Cut back to the widget. | — |
| 0:10–0:11 | Click a row from a **different agent**. | — |
| 0:11–0:13 | Second terminal resumes. | “Different agent. Same one click.” |
| 0:13–0:15 | End card: app icon, “DevSessions”, “Free. Local. Open source.”, repo URL. | — |

**README cut:** use 0:00–0:08 only (widget → click → terminal). It loops cleanly and stays small.

**End-card copy:**
> DevSessions
> Every AI coding session. One click away.
> Free. Local. Open source.
> github.com/prashanthgit19/devsessions

---

## 4. Capture

1. Open QuickTime Player → **File → New Screen Recording**.
2. Record the full screen (you need the desktop widget and the terminal). If the resolution is 2560×1664, record at that size and crop in iMovie.
3. Click the record button, wait 1 second, then perform the flow.
4. Stop recording. Save as `demo-raw.mov`.
5. Record **three takes**. Pick the cleanest one; do not try to nail it in one pass.
6. If the agent takes more than ~2 seconds to load, keep the footage but cut the loading in editing. Do not fake the result.

**Tip:** use a larger cursor (`System Settings → Accessibility → Display → Pointer size`) so it reads on mobile.

---

## 5. Edit in iMovie

1. Import `demo-raw.mov`.
2. Trim to 15 seconds using the shot list above.
3. Add captions with **Titles → Lower Third** or a simple centered title. White text, subtle shadow, large enough to read on a phone.
4. Add a 0.2–0.3 s cross-dissolve between the two resume moments if it feels choppy.
5. Make the end card in Keynote:
   - 1920×1080, dark plum background (`#2A1B3D`).
   - App icon on the left, name and tagline on the right.
   - Export as PNG, drag it into iMovie, hold for 2 seconds.
6. Export: **File → Share → File → 1080p, 30 fps, H.264, high quality**.

---

## 6. Make the README GIF

Install FFmpeg once (free):

```sh
brew install ffmpeg
```

Trim the video to the widget → click → terminal moment (about 8 seconds), then:

```sh
ffmpeg -i demo-8s.mp4 -vf "fps=15,scale=1200:-1:flags=lanczos,palettegen" palette.png
ffmpeg -i demo-8s.mp4 -i palette.png \
  -lavfi "fps=15,scale=1200:-1:flags=lanczos[x];[x][1:v]paletteuse" demo.gif
```

Target **under 8 MB**. If it is larger, drop to 1000 px and 12 fps, or cut the clip to 6 seconds.

Put it at the top of `README.md`:

```md
![DevSessions demo](docs/demo.gif)
```

---

## 7. The install video (30 seconds, also free)

This is required if you are not notarizing. It is the difference between “this looks sketchy” and “I know what to do.”

1. Open the GitHub release page.
2. Click the DMG, show the download.
3. Open the DMG, drag `DevSessions.app` to Applications.
4. Launch it. Show the “Apple could not verify” dialog.
5. Open **System Settings → Privacy & Security**, scroll to Security, click **Open Anyway**, authenticate, click **Open**.
6. Show the app running and the widget gallery.
7. End card: “One-time setup. Then it just works.” + repo URL.

Add captions. Put it above the download button and in the release notes.

---

## 8. Screenshots and OG image

Capture these six:

1. Large widget on a clean desktop (hero).
2. Small, medium, and large widgets together.
3. Settings → Widget theme cards.
4. Settings → Terminal (Terminal.app / Ghostty).
5. Settings → Agents diagnostics.
6. Menu bar menu open.

Use `Cmd+Shift+4` then Space to capture windows with their shadow. For the widget, capture a desktop region and crop.

**OG image (1280×640):** left side app icon + “DevSessions” + “Every AI coding session. One click away.”; right side a cropped widget screenshot. Use the same image for GitHub social preview, Product Hunt thumbnail, and X card.

---

## 9. Where each asset goes

| Asset | Placement |
|---|---|
| 15 s MP4 | X, Reddit, Product Hunt, landing page hero |
| 8 s GIF | README top, GitHub release notes |
| 30 s install MP4 | Download page, release notes, README install section |
| 6 screenshots | Landing page, Product Hunt gallery, Reddit posts |
| OG image | GitHub social preview, PH thumbnail, X card |

---

## 10. Two-day schedule

**Day 1**
- Morning: create demo projects/sessions, clean the desktop, rehearse.
- Afternoon: record three takes, pick the best, trim the 15 s cut.

**Day 2**
- Morning: captions, end card, export MP4, make the GIF.
- Afternoon: screenshots, OG image, install video, upload to README/release.
- Evening: soft-launch to 5–10 people and watch them install.

---

## 11. Free vs paid

**Free:** repo rename, GitHub Pages, recording, editing, GIF, screenshots, Homebrew tap, HN/Reddit/PH/X posts, GitHub Releases.

**Paid and optional:** Apple Developer Program, $99/year, only for notarization. It removes the one-time Gatekeeper approval. You can launch without it; expect a meaningful drop-off at install. The install video is the free mitigation.

**Also optional:** a custom domain (~$10/year). The free `prashanthgit19.github.io/devsessions` URL is fine until you have traction.
