import SwiftUI

/// Simple line-art silhouettes for each glass type. Drawn in a unit square and scaled to the rect.
struct GlassShape: Shape {
    let glass: Glass

    func path(in rect: CGRect) -> Path {
        var path = Path()
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: rect.minX + x * rect.width, y: rect.minY + y * rect.height)
        }
        func stem(from top: CGFloat, to bottom: CGFloat = 0.9, footWidth: CGFloat = 0.4) {
            path.move(to: pt(0.5, top))
            path.addLine(to: pt(0.5, bottom))
            path.move(to: pt(0.5 - footWidth / 2, bottom))
            path.addLine(to: pt(0.5 + footWidth / 2, bottom))
        }

        switch glass {
        case .cocktail:
            path.move(to: pt(0.08, 0.1))
            path.addLine(to: pt(0.92, 0.1))
            path.addLine(to: pt(0.5, 0.5))
            path.closeSubpath()
            stem(from: 0.5)

        case .oldFashioned:
            path.addRoundedRect(in: CGRect(x: rect.minX + 0.18 * rect.width, y: rect.minY + 0.4 * rect.height,
                                           width: 0.64 * rect.width, height: 0.52 * rect.height),
                                cornerSize: CGSize(width: 4, height: 4))

        case .highball:
            path.addRoundedRect(in: CGRect(x: rect.minX + 0.3 * rect.width, y: rect.minY + 0.12 * rect.height,
                                           width: 0.4 * rect.width, height: 0.8 * rect.height),
                                cornerSize: CGSize(width: 3, height: 3))

        case .collins:
            path.addRoundedRect(in: CGRect(x: rect.minX + 0.34 * rect.width, y: rect.minY + 0.04 * rect.height,
                                           width: 0.32 * rect.width, height: 0.9 * rect.height),
                                cornerSize: CGSize(width: 3, height: 3))

        case .footedPilsner:
            path.move(to: pt(0.28, 0.05))
            path.addLine(to: pt(0.72, 0.05))
            path.addLine(to: pt(0.6, 0.72))
            path.addLine(to: pt(0.4, 0.72))
            path.closeSubpath()
            stem(from: 0.72, footWidth: 0.36)

        case .sour:
            path.move(to: pt(0.28, 0.1))
            path.addLine(to: pt(0.72, 0.1))
            path.addQuadCurve(to: pt(0.5, 0.58), control: pt(0.72, 0.5))
            path.addQuadCurve(to: pt(0.28, 0.1), control: pt(0.28, 0.5))
            stem(from: 0.58)

        case .liqueur:
            path.move(to: pt(0.38, 0.32))
            path.addLine(to: pt(0.62, 0.32))
            path.addLine(to: pt(0.56, 0.62))
            path.addLine(to: pt(0.44, 0.62))
            path.closeSubpath()
            stem(from: 0.62, footWidth: 0.3)

        case .sherry:
            path.move(to: pt(0.32, 0.2))
            path.addLine(to: pt(0.68, 0.2))
            path.addLine(to: pt(0.57, 0.62))
            path.addLine(to: pt(0.43, 0.62))
            path.closeSubpath()
            stem(from: 0.62, footWidth: 0.34)

        case .saucerChampagne:
            path.move(to: pt(0.1, 0.18))
            path.addLine(to: pt(0.9, 0.18))
            path.addQuadCurve(to: pt(0.5, 0.46), control: pt(0.85, 0.46))
            path.addQuadCurve(to: pt(0.1, 0.18), control: pt(0.15, 0.46))
            stem(from: 0.46)

        case .fluteChampagne:
            path.move(to: pt(0.4, 0.05))
            path.addLine(to: pt(0.6, 0.05))
            path.addLine(to: pt(0.57, 0.62))
            path.addLine(to: pt(0.43, 0.62))
            path.closeSubpath()
            stem(from: 0.62, footWidth: 0.34)

        case .whiteWine:
            path.move(to: pt(0.3, 0.08))
            path.addLine(to: pt(0.7, 0.08))
            path.addQuadCurve(to: pt(0.5, 0.6), control: pt(0.84, 0.58))
            path.addQuadCurve(to: pt(0.3, 0.08), control: pt(0.16, 0.58))
            stem(from: 0.6)
        }
        return path
    }
}

struct GlassIcon: View {
    let glass: Glass
    var size: CGFloat = 64
    var lineWidth: CGFloat = 2

    var body: some View {
        GlassShape(glass: glass)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
        ForEach(Glass.allCases) { glass in
            VStack {
                GlassIcon(glass: glass)
                Text(glass.rawValue).font(.body)
            }
        }
    }
    .padding()
}
