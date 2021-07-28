
import Foundation

public struct Point: Codable {
    public var x: Double
    public var y: Double

    public static let zero = Point(x: 0, y: 0)

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public func offsetBy(_ offset: Point) -> Point {
        return Point(x: x + offset.x, y: y + offset.y)
    }

    public func offsetBy(x: Double, y: Double) -> Point {
        return offsetBy(Point(x: x, y: y))
    }

    public func diffOf(_ point: Point) -> Point {
        return Point(x: x - point.x, y: y - point.y)
    }

    public func distanceFrom(_ otherPoint: Point) -> Double {
        let xDist = x - otherPoint.x
        let yDist = y - otherPoint.y
        return Double(sqrt((xDist * xDist) + (yDist * yDist)))
    }

    public func roundedUp() -> Point {
        return Point(x: ceil(x), y: ceil(y))
    }
    
    var length: Double {
        Double(sqrt((x * x) + (y * y)))
    }

}

extension Point: CustomStringConvertible {
    public var description: String {
        return "x:\(x), y:\(y)"
    }
}

extension Point: Equatable {}

public func == (_ lhs: Point, _ rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

extension Point: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
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
