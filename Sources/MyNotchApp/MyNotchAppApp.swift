import SwiftUI

@main
struct MyNotchApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // Menu bar icon + dropdown settings
        MenuBarExtra("MyNotchApp", systemImage: "sparkles") {
            MenuBarView()
        }
        .menuBarExtraStyle(.window)

        // No main window — the notch panel is managed by AppDelegate
        Settings {
            SettingsView()
        }
    }
}
