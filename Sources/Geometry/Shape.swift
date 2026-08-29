import Foundation

public enum Shape: Hashable, Codable, Sendable {
    case circle(Circle)
    case rect(Rect)
    case triangle(Triangle)
    case polygon(Path)
    case line(Line, width: Double)
}
