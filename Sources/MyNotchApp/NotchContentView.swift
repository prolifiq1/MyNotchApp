import SwiftUI

struct NotchContentView: View {
    @StateObject private var monitor = SessionMonitor()

    var body: some View {
        HStack(spacing: 12) {
            // Pixel art mascot on the left of the notch
            PixelArtCanvas(
                sprite: MascotSprites.robot,
                animating: monitor.status == .processing
            )
            .frame(width: 32, height: 32)

            // Spacer to leave room for the physical notch
            Spacer()
                .frame(width: 90)

            // Status indicator on the right of the notch
            StatusPill(status: monitor.status)
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Status Pill

struct StatusPill: View {
    let status: SessionStatus

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(status.color)
                .frame(width: 6, height: 6)

            Text(status.label)
                .font(.system(size: 10, weight: .medium, design: .monospaced))
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(.black.opacity(0.5))
                .overlay(
                    // Liquid shimmer highlight when processing
                    shimmerOverlay
                )
        )
    }

    @ViewBuilder
    private var shimmerOverlay: some View {
        if status == .processing {
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.15), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .phaseAnimator([false, true]) { content, phase in
                    content.offset(x: phase ? 40 : -40)
                } animation: { _ in
                    .easeInOut(duration: 1.2).repeatForever(autoreverses: false)
                }
        }
    }
}

// MARK: - Session Status

enum SessionStatus: String {
    case idle
    case processing
    case waitingForInput
    case needsApproval

    var label: String {
        switch self {
        case .idle:             return "Idle"
        case .processing:       return "Working…"
        case .waitingForInput:  return "Input?"
        case .needsApproval:    return "Approve"
        }
    }

    var color: Color {
        switch self {
        case .idle:             return .gray
        case .processing:       return .green
        case .waitingForInput:  return .yellow
        case .needsApproval:    return .orange
        }
    }
}
