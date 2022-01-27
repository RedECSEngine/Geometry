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
    
    public func intersects(_ p: Point) -> Bool {
        (a.distanceFrom(p) + b.distanceFrom(p)) - a.distanceFrom(b) < 0.0001
    }
    
    public var dotProduct: Double {
        a.x * b.x + a.y * b.y
    }
    
    public func project(on line: Line) -> Point {
        let u = (a - b)
        let v = (line.a - line.b)
        let p = (u.x * v.x + u.y * v.y) / (v.x * v.x + v.y * v.y)
        return (v * p)
    }
    
    public func intersects(_ c: Circle) -> Bool {
        return distance(to: c.center) <= c.radius
    }
    
    public func distance(to p: Point) -> Double {
        let ac = p - a
        let ab = p - b
        let d = Line(a: .zero, b: ac).project(on: Line(a: .zero, b: ab)) + a
//        let ad = d - a
        
        // Determine whether to measure distance by a(start), b(end), or d(projected mid point)
        return min(
            min(
                sqrt(Line(a: p - a, b: p - a).dotProduct),
                sqrt(Line(a: p - b, b: p - b).dotProduct)),
            sqrt(Line(a: p - d, b: p - d).dotProduct)
        )
//        let k = abs(ab.x) > abs(ab.y) ? (ad.x / ab.x) : (ad.y / ab.y)
//        if k <= 0.0 {
//            return sqrt(Line(a: p - a, b: p - a).dotProduct)
//        } else if k >= 1.0 {
//            return sqrt(Line(a: p - b, b: p - b).dotProduct)
//        }
//        return sqrt(Line(a: p - d, b: p - d).dotProduct);
    }

}

extension Line: CustomStringConvertible {
    public var description: String {
        "a:\(a), b:\(b)"
    }
}
