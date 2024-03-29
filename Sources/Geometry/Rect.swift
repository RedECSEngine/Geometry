public struct Rect: Hashable, Codable {
    public var origin: Point
    public var size: Size
    
    public static let zero = Rect(x: 0, y: 0, width: 0, height: 0)

    public init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        origin = Point(x: originX, y: originY)
        self.size = size
        adjustForNegativeSizes()
    }

    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
        adjustForNegativeSizes()
    }

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
        adjustForNegativeSizes()
    }

    fileprivate mutating func adjustForNegativeSizes() {
        if size.width < 0 {
            origin.x -= size.width
            size.width = abs(size.width)
        }
        if size.height < 0 {
            origin.y -= size.height
            size.height = abs(size.height)
        }
    }
    
    public func offset(by point: Point) -> Rect {
        Rect(center: center.offsetBy(point), size: size)
    }

}

extension Rect {
    public var minX: Double {
        return origin.x
    }

    public var minY: Double {
        return origin.y
    }

    public var maxX: Double {
        return origin.x + size.width
    }

    public var maxY: Double {
        return origin.y + size.height
    }

    public var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            let originX = newValue.x - (size.width / 2)
            let originY = newValue.y - (size.height / 2)
            origin = Point(x: originX, y: originY)
        }
    }

    public var end: Point {
        return origin.offsetBy(Point(x: size.width, y: size.height))
    }

    public var diagonalLength: Double {
        return origin.distanceFrom(end)
    }
    
    public func contains(_ point: Point) -> Bool {
        return point.x >= minX && point.x < maxX
            && point.y >= minY && point.y < maxY
    }

    public func contains(_ rect2: Rect) -> Bool {
        return
            contains(rect2.origin)
                && contains(Point(x: rect2.maxX, y: rect2.minY))
                && contains(Point(x: rect2.maxX, y: rect2.maxY))
                && contains(Point(x: rect2.minX, y: rect2.maxY))
    }

    public func intersects(line: (Point, Point)) -> Bool {
        return
            (line.0.x > minX && line.0.x < maxX && line.0.y > minY && line.0.y < maxY)
                || (line.1.x > minX && line.1.x < maxX && line.1.y > minY && line.1.y < maxY)
    }

    public func intersects(_ rect2: Rect) -> Bool {
        return minX < rect2.maxX && rect2.minX < maxX &&
            minY < rect2.maxY && rect2.minY < maxY
    }

    public func inset(by inset: Double) -> Rect {
        let newSize = Size(width: size.width - (inset * 2), height: size.height - (inset * 2))
        return Rect(center: center, size: newSize)
    }
}

extension Rect: CustomStringConvertible {
    public var description: String {
        return "\(origin.description)/\(size.description)"
    }
}

