import Geometry

public protocol Triangulatable {
    func triangulate() throws -> [Triangle]
}

extension Circle: Triangulatable {
    public func triangulate() throws -> [Triangle] {
        GeometryAlgorithms.triangulateCircle(self)
    }
}

extension Rect: Triangulatable {
    public func triangulate() throws -> [Triangle] {
        GeometryAlgorithms.triangulateRect(self)
    }
}

extension Path: Triangulatable {
    public func triangulate() throws -> [Triangle] {
        try GeometryAlgorithms.triangulatePolygon(self)
    }
}

extension Shape: Triangulatable {
    public func triangulate() throws -> [Triangle] {
        switch self {
        case .circle(let circle):
            return try circle.triangulate()
        case .rect(let rect):
            return try rect.triangulate()
        case .triangle(let triangle):
            return [triangle]
        case .polygon(let path):
            return try path.triangulate()
        }
    }
}
