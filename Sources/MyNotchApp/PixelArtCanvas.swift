import SwiftUI

/// Renders an 8×8 pixel art sprite using SwiftUI Canvas.
/// Each cell in the grid maps to a colour; `0` = transparent.
struct PixelArtCanvas: View {
    let sprite: [[Int]]
    var animating: Bool = false

    @State private var bounce: Bool = false

    var body: some View {
        Canvas { context, size in
            let cols = sprite.first?.count ?? 8
            let rows = sprite.count
            let cellW = size.width / CGFloat(cols)
            let cellH = size.height / CGFloat(rows)

            for row in 0..<rows {
                for col in 0..<cols {
                    let colorIndex = sprite[row][col]
                    guard colorIndex != 0 else { continue } // transparent

                    let color = Palette.color(for: colorIndex)
                    let rect = CGRect(
                        x: CGFloat(col) * cellW,
                        y: CGFloat(row) * cellH,
                        width: cellW,
                        height: cellH
                    )
                    context.fill(Path(rect), with: .color(color))
                }
            }
        }
        .offset(y: bounce ? -2 : 0)
        .animation(
            animating
                ? .easeInOut(duration: 0.5).repeatForever(autoreverses: true)
                : .default,
            value: bounce
        )
        .onChange(of: animating) { _, isAnimating in
            bounce = isAnimating
        }
    }
}

// MARK: - Colour Palette

/// Maps integer IDs in the sprite grid to actual colours.
/// Extend this with as many colours as your mascots need.
enum Palette {
    static func color(for index: Int) -> Color {
        switch index {
        case 1: return .white
        case 2: return Color(red: 0.2, green: 0.2, blue: 0.2)   // dark grey
        case 3: return Color(red: 0.0, green: 0.8, blue: 1.0)   // cyan
        case 4: return Color(red: 1.0, green: 0.3, blue: 0.3)   // red
        case 5: return Color(red: 0.3, green: 1.0, blue: 0.3)   // green
        case 6: return Color(red: 1.0, green: 0.85, blue: 0.0)  // yellow
        case 7: return Color(red: 0.6, green: 0.4, blue: 1.0)   // purple
        default: return .gray
        }
    }
}
