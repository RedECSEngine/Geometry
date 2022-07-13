import Foundation

public struct Triangle: Hashable, Codable {
    public var a: Point
    public var b: Point
    public var c: Point

    public init(a: Point, b: Point, c: Point) {
        self.a = a
        self.b = b
        self.c = c
    }
    
    public var center: Point {
        Point(
            x: (a.x + b.x + c.x) / 3,
            y: (a.y + b.y + c.y) / 3
        )
    }
    
    public func offset(by amount: Point) -> Triangle {
        Triangle(
            a: a.offsetBy(amount),
            b: b.offsetBy(amount),
            c: c.offsetBy(amount)
        )
    }
}

extension Triangle {
    /// https://stackoverflow.com/a/2049593/315623
    /// How to determine if a point is in a 2D triangle?
    public func contains(_ point: Point) -> Bool {
        let d1 = sign(point, a, b);
        let d2 = sign(point, b, c);
        let d3 = sign(point, c, a);
        
        let hasNegative = (d1 < 0) || (d2 < 0) || (d3 < 0);
        let hasPositive = (d1 > 0) || (d2 > 0) || (d3 > 0);

        return !(hasNegative && hasPositive)
    }
    
    private func sign(_ p1: Point, _ p2: Point, _ p3: Point) -> Double {
        (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)
    }
}

extension Triangle: CustomStringConvertible {
    public var description: String {
        "a:\(a), b:\(b), c: \(c)"
    }
}
