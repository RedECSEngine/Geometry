import Geometry

public enum GeometryAlgorithms {}

public extension GeometryAlgorithms {
    static func crossProduct(_ a: Point, b: Point) -> Double {
        a.x * b.y - a.y * b.x
    }
}
