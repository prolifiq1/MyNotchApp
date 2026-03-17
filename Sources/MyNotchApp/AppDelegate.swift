import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var notchPanel: NotchPanel?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide dock icon — this is a menu bar / notch-only app
        NSApp.setActivationPolicy(.accessory)

        // Create and show the notch overlay
        setupNotchPanel()
    }

    @MainActor private func setupNotchPanel() {
        guard let screen = NSScreen.main else { return }

        // Panel dimensions — sized to sit around the notch
        let panelWidth: CGFloat = 250
        let panelHeight: CGFloat = 38

        // Position: top-center of screen, aligned with the notch
        let screenFrame = screen.frame
        let x = screenFrame.midX - (panelWidth / 2)
        let y = screenFrame.maxY - panelHeight

        let frame = NSRect(x: x, y: y, width: panelWidth, height: panelHeight)

        notchPanel = NotchPanel(
            contentRect: frame,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        guard let panel = notchPanel else { return }

        // Configure panel to float above everything
        panel.level = .statusBar + 1
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = false
        panel.ignoresMouseEvents = false
        panel.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary]
        panel.isMovableByWindowBackground = false

        // Embed the SwiftUI notch view
        let hostingView = NSHostingView(rootView: NotchContentView())
        hostingView.frame = panel.contentView?.bounds ?? frame
        hostingView.autoresizingMask = [.width, .height]
        panel.contentView?.addSubview(hostingView)

        panel.orderFrontRegardless()
    }
}
