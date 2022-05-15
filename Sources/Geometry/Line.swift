import Foundation

public struct Line: Hashable, Codable {
    public var a: Point
    public var b: Point

    public init(a: Point, b: Point) {
        self.a = a
        self.b = b
    }
    
    public var length: Double {
        a.distanceFrom(b)
    }
    
    public var center: Point {
        Point(
            x: (a.x + b.x) / 2,
            y: (a.y + b.y) / 2
        )
    }
    
    public var isHorizontal: Bool {
        a.y == b.y
    }
    
    public var isVertical: Bool {
        a.x == b.x
    }
    
    public func intersects(_ p: Point) -> Bool {
        (a.distanceFrom(p) + b.distanceFrom(p)) - a.distanceFrom(b) < 0.0001
    }
    
    public func offset(by amount: Point) -> Line {
        Line(a: a.offsetBy(amount), b: b.offsetBy(amount))
    }
    
    public func project(on line: Line) -> Point {
        let u = (a - b)
        let v = (line.a - line.b)
        let p = (u.x * v.x + u.y * v.y) / (v.x * v.x + v.y * v.y)
        return (v * p)
    }
    
    public func intersects(_ c: Circle) -> Bool {
        // First check if the ends of the line are within the circle
        if c.contains(a) || c.contains(b) {
            return true
        }
        // If not, use projection to determine if there is intersection along the line
        let proj = a + Line(a: c.center, b: a).project(on: self)
        let acLength = proj.distanceFrom(a)
        let bcLength = proj.distanceFrom(b)
        let calculatedLength = acLength + bcLength
        return (c.center.distanceFrom(proj) <= c.radius) && (calculatedLength == length)
    }
}

extension Line: CustomStringConvertible {
    public var description: String {
        "a:\(a), b:\(b)"
    }
}
