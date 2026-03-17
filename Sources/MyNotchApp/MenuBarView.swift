import SwiftUI

struct MenuBarView: View {
    @StateObject private var monitor = SessionMonitor()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Status header
            HStack {
                Circle()
                    .fill(monitor.status.color)
                    .frame(width: 8, height: 8)
                Text("Claude: \(monitor.status.label)")
                    .font(.headline)
            }

            Divider()

            // Quick mascot preview
            HStack(spacing: 12) {
                ForEach(MascotSprites.all.prefix(4), id: \.name) { mascot in
                    VStack(spacing: 2) {
                        PixelArtCanvas(sprite: mascot.sprite)
                            .frame(width: 24, height: 24)
                        Text(mascot.name)
                            .font(.system(size: 8))
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Divider()

            Button("Settings…") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            }
            .keyboardShortcut(",", modifiers: .command)

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: .command)
        }
        .padding()
        .frame(width: 220)
    }
}
