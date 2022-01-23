
import Foundation

public struct Point: Hashable, Codable {
    public var x: Double
    public var y: Double

    public static let zero = Point(x: 0, y: 0)

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public func offsetBy(_ offset: Point) -> Point {
        Point(x: x + offset.x, y: y + offset.y)
    }

    public func offsetBy(x: Double, y: Double) -> Point {
        offsetBy(Point(x: x, y: y))
    }

    public func diffOf(_ point: Point) -> Point {
        Point(x: x - point.x, y: y - point.y)
    }

    public func distanceFrom(_ otherPoint: Point) -> Double {
        sqrt(pow(x - otherPoint.x, 2) + pow(y - otherPoint.y, 2))
    }

    public func roundedUp() -> Point {
        Point(x: ceil(x), y: ceil(y))
    }
    
    public var length: Double {
        sqrt((x * x) + (y * y))
    }
    
    public func normalized(to maxValue: Double) -> Point {
        var new = self
        new.normalize(to: maxValue)
        return new
    }
    
    public mutating func normalize(to maxValue: Double) {
        guard length > 0 else { return }
        self = (self / length) * maxValue
    }

}

extension Point: CustomStringConvertible {
    public var description: String {
        "x:\(x), y:\(y)"
    }
}

public func + (_ lhs: Point, _ rhs: Point) -> Point {
    Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func += (_ lhs: inout Point, _ rhs: Point) {
    lhs = Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (_ lhs: Point, _ rhs: Point) -> Point {
    Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -= (_ lhs: inout Point, _ rhs: Point) {
    lhs = Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func * (_ lhs: Point, _ rhs: Double) -> Point {
    Point(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func *= (_ lhs: inout Point, _ rhs: Double) {
    lhs = Point(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func * (_ lhs: Point, _ rhs: Point) -> Point {
    Point(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func / (_ lhs: Point, _ rhs: Double) -> Point {
    Point(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func /= (_ lhs: inout Point, _ rhs: Double) {
    lhs = Point(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func / (_ lhs: Point, _ rhs: Point) -> Point {
    Point(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}
