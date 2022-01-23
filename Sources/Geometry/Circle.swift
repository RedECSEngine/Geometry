import Foundation

public struct Circle: Hashable, Codable {
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

//    public func intersects(_ circle2: Circle) -> Bool {
//        let radiusDiff = pow(radius - circle2.radius, 2)
//        let centerXDiff = pow(center.x - circle2.center.x, 2)
//        let centerYDiff = pow(center.y - circle2.center.y, 2)
//        let radiusCombine = pow(radius + circle2.radius, 2)
//
//        let centerDiffCombine = centerXDiff + centerYDiff
//
//        return radiusDiff <= centerDiffCombine
//            && centerDiffCombine <= radiusCombine
//    }
    
    public func intersects(_ circle2: Circle) -> Bool {
        center.distanceFrom(circle2.center) <= radius + circle2.radius
    }
    
    public func contains(_ point: Point) -> Bool {
        (pow(point.x - center.x, 2) + pow(point.y - center.y, 2)) < pow(radius, 2)
    }
}
