import Geometry

public extension GeometryAlgorithms {
    static func triangulateRect(_ rect: Rect) -> [Triangle] {
        return [
            Triangle(
                a: .init(x: rect.minX, y: rect.minY),
                b: .init(x: rect.minX, y: rect.maxY),
                c: .init(x: rect.maxX, y: rect.minY )
            ),
            Triangle(
                a: .init(x: rect.maxX, y: rect.maxY),
                b: .init(x: rect.minX, y: rect.maxY),
                c: .init(x: rect.maxX, y: rect.minY)
            ),
        ]
    }
}
