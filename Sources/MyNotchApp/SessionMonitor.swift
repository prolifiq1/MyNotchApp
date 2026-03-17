import Foundation
import Combine

/// Monitors the system for running Claude Code sessions.
@MainActor
class SessionMonitor: ObservableObject {
    @Published var status: SessionStatus = .idle

    private var timer: Timer?

    init() {
        startPolling()
    }

    func stopPolling() {
        timer?.invalidate()
        timer = nil
    }

    private func startPolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.checkClaudeStatus()
            }
        }
    }

    private func checkClaudeStatus() {
        let claudeDir = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".claude")

        if FileManager.default.fileExists(atPath: claudeDir.path) {
            if let sessions = try? FileManager.default.contentsOfDirectory(
                at: claudeDir,
                includingPropertiesForKeys: [.contentModificationDateKey],
                options: .skipsHiddenFiles
            ) {
                let recentlyModified = sessions.filter { url in
                    guard let attrs = try? url.resourceValues(forKeys: [.contentModificationDateKey]),
                          let modified = attrs.contentModificationDate else { return false }
                    return Date().timeIntervalSince(modified) < 10
                }

                if !recentlyModified.isEmpty {
                    status = .processing
                    return
                }
            }
        }

        let task = Process()
        let pipe = Pipe()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/pgrep")
        task.arguments = ["-x", "claude"]
        task.standardOutput = pipe
        task.standardError = FileHandle.nullDevice

        do {
            try task.run()
            task.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            status = output.isEmpty ? .idle : .processing
        } catch {
            status = .idle
        }
    }
}
