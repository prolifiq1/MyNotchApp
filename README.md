# MyNotchApp

A macOS notch companion that monitors your Claude Code sessions with animated pixel art mascots.

## Features

- **Pixel art mascots** — 6 characters rendered via SwiftUI Canvas
- **Session monitoring** — detects active Claude Code sessions
- **Shimmer progress** — animated highlight on the status pill
- **Menu bar integration** — quick status view + settings
- **Theme colours** — 6 presets to personalise the notch UI

## Requirements

- macOS 15.0+
- Apple Silicon Mac with notch display
- Xcode 16+
- Claude Code CLI (for session monitoring)

## Build & Run

### With Xcode

```bash
open Package.swift
# Xcode opens → select "My Mac" target → Cmd+R
```

### With Swift CLI

```bash
swift build
swift run MyNotchApp
```

### With Claude Code

```bash
cd MyNotchApp
claude
> Build and run this project, fix any errors
```

## Project Structure

```
Sources/MyNotchApp/
├── MyNotchAppApp.swift      # App entry point (MenuBarExtra)
├── AppDelegate.swift         # Creates the notch overlay panel
├── NotchPanel.swift          # NSPanel subclass (transparent, non-activating)
├── NotchContentView.swift    # SwiftUI view inside the notch
├── PixelArtCanvas.swift      # Canvas-based 8×8 sprite renderer
├── MascotSprites.swift       # Pixel grid data for each mascot
├── SessionMonitor.swift      # Polls for active Claude Code sessions
├── MenuBarView.swift         # Menu bar dropdown
└── SettingsView.swift        # Mascot + theme preferences
```

## Claude Code Workflow

This project was scaffolded and iterated with Claude Code:

```bash
claude
> Add notification sounds when Claude Code status changes
> Add a DMG packaging script for releases
> Fix the panel positioning on external displays
```

## License

MIT
