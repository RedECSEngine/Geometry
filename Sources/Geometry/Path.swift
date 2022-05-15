public struct Path: Hashable, Codable {
    public var points: [Point]
    public init(points: [Point] = []) {
        self.points = points
    }
    
    public var lines: AnySequence<Line> {
        AnySequence { () -> AnyIterator<Line> in 
            var i = 0
            return AnyIterator { () -> Line? in
                if i >= points.count - 1 {
                    return nil
                }
                let line = Line(a: points[i], b: points[i + 1])
                i += 1
                return line
            }
        }
    }
    
    public func calculateContainingRect() -> Rect {
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

