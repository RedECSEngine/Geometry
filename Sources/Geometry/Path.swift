import Foundation

public struct Path: Hashable, Codable {
    public var points: [Point]
    public init(points: [Point] = []) {
        self.points = points
    }
}

