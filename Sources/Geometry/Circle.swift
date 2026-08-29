public struct Circle: Hashable, Codable, Sendable {
    public var center: Point
    public var radius: Double

    public var diameter: Double { radius * 2 }
    
    public init(
        center: Point = .zero,
        radius: Double
    ) {
        self.radius = radius
        self.center = center
    }
    
    public init(fittedTo rect: Rect) {
        radius = rect.diagonalLength / 2
        center = rect.center
    }
    
    @available(*, deprecated, renamed: "offsetBy(_:)", message: "Renamed")
    public func offset(by point: Point) -> Circle {
        offsetBy(point)
    }
    
    public func offsetBy(_ amount: Point) -> Circle {
        Circle(center: center.offsetBy(amount), radius: radius)
    }
    
    public func intersects(_ circle2: Circle) -> Bool {
        center.distanceFrom(circle2.center) <= radius + circle2.radius
    }
    
    public func contains(_ point: Point) -> Bool {
        center.distanceFrom(point) <= radius
    }
    
    public var size: Size {
        Size(width: diameter, height: diameter)
    }
}
