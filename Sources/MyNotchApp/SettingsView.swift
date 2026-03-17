import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedMascot") private var selectedMascot: String = "Robot"
    @AppStorage("themeColor") private var themeColor: String = "Cyan"

    private let themeColors: [(name: String, color: Color)] = [
        ("Cyan",   Color(red: 0.0, green: 0.8, blue: 1.0)),
        ("Green",  Color(red: 0.3, green: 1.0, blue: 0.3)),
        ("Purple", Color(red: 0.6, green: 0.4, blue: 1.0)),
        ("Orange", Color(red: 1.0, green: 0.6, blue: 0.2)),
        ("Pink",   Color(red: 1.0, green: 0.4, blue: 0.7)),
        ("Yellow", Color(red: 1.0, green: 0.85, blue: 0.0)),
    ]

    var body: some View {
        TabView {
            // MARK: - General
            Form {
                Section("Mascot") {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(64)), count: 3), spacing: 12) {
                        ForEach(MascotSprites.all, id: \.name) { mascot in
                            VStack(spacing: 4) {
                                PixelArtCanvas(sprite: mascot.sprite)
                                    .frame(width: 40, height: 40)
                                    .padding(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(selectedMascot == mascot.name
                                                  ? Color.accentColor.opacity(0.2)
                                                  : Color.clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedMascot == mascot.name
                                                    ? Color.accentColor
                                                    : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        selectedMascot = mascot.name
                                    }

                                Text(mascot.name)
                                    .font(.caption2)
                            }
                        }
                    }
                }

                Section("Theme Color") {
                    HStack(spacing: 12) {
                        ForEach(themeColors, id: \.name) { theme in
                            Circle()
                                .fill(theme.color)
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Circle()
                                        .stroke(.white, lineWidth: themeColor == theme.name ? 2 : 0)
                                )
                                .shadow(color: themeColor == theme.name ? theme.color.opacity(0.6) : .clear, radius: 4)
                                .onTapGesture {
                                    themeColor = theme.name
                                }
                        }
                    }
                }
            }
            .tabItem { Label("General", systemImage: "gear") }
            .padding()
            .frame(width: 360, height: 380)
        }
    }
}
