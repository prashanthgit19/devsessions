import AppKit

enum MenuBarIcon {
    static let image: NSImage = {
        let image = NSImage(
            size: NSSize(width: 18, height: 18),
            flipped: false
        ) { rect in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) * 0.345
            let lineWidth: CGFloat = 1.8

            let ring = NSBezierPath()
            ring.appendArc(
                withCenter: center,
                radius: radius,
                startAngle: 70,
                endAngle: 380,
                clockwise: false
            )
            ring.lineWidth = lineWidth
            ring.lineCapStyle = .round
            NSColor.black.setStroke()
            ring.stroke()

            let dotAngle = 45.0 * .pi / 180
            let dotRadius: CGFloat = 1.7
            let dotCenter = CGPoint(
                x: center.x + radius * cos(dotAngle),
                y: center.y + radius * sin(dotAngle)
            )
            let dot = NSBezierPath(
                ovalIn: NSRect(
                    x: dotCenter.x - dotRadius,
                    y: dotCenter.y - dotRadius,
                    width: dotRadius * 2,
                    height: dotRadius * 2
                )
            )
            NSColor.black.setFill()
            dot.fill()

            return true
        }

        image.isTemplate = true
        image.accessibilityDescription = "DevSessions"
        return image
    }()
}
