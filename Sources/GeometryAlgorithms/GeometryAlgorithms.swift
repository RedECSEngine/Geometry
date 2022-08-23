import Geometry

public enum GeometryAlgorithms {}

public extension GeometryAlgorithms {
    static func crossProduct(_ a: Point, b: Point) -> Double {
        a.x * b.y - a.y * b.x
    }
    
    static func calculateContainingRect(of points: [Point]) -> Rect {
        var minX: Double = 0
        var minY: Double = 0
        var maxX: Double = 0
        var maxY: Double = 0
        
        for point in points {
            if point.x < minX {
                minX = point.x
            }
            if point.x < minY {
                minY = point.y
            }
            if point.x > maxX {
                maxX = point.x
            }
            if point.y > maxY {
                maxY = point.y
            }
        }
        return Rect(origin: .zero, size: Size(width: maxX - minX, height: maxY - minY))
    }
}
