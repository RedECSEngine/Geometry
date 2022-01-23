import SpriteKit
import Geometry

public extension Point {
    func makeCGPoint() -> CGPoint {
        CGPoint(x: self.x, y: self.y)
    }
}

public extension Size {
    func makeCGSize() -> CGSize {
        CGSize(width: width, height: height)
    }
}

public extension Rect {
    func makeCGRect() -> CGRect {
        CGRect(origin: origin.makeCGPoint(), size: size.makeCGSize())
    }
    
    func makeCGPath() -> CGPath {
        return CGPath(rect: makeCGRect(), transform: nil)
    }
}

public extension Path {
    func makeCGPath() -> CGPath {
        let path = CGMutablePath()
        guard let firstPoint = points.first else { return path }
        path.move(to: firstPoint.makeCGPoint())
        for point in points.dropFirst() {
            path.addLine(to: CGPoint(x: point.x, y: point.y))
        }
        path.closeSubpath()
        return path
    }
}

public extension Circle {
    func makeCGPath() -> CGPath {
        CGPath(
            ellipseIn: .init(
                origin: .zero,
                size: .init(width: diameter, height: diameter)
            ),
            transform: nil
        )
    }
}

public extension Shape {
    func makeCGPath() -> CGPath {
        switch self {
        case .circle(let circle):
            return circle.makeCGPath()
        case .rect(let rect):
            return rect.makeCGPath()
        case .polygon(let path):
            return path.makeCGPath()
        }
    }
}
