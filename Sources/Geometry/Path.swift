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
}

