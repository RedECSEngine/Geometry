import Foundation

public enum Shape: Hashable, Codable {
    case circle(Circle)
    case rect(Rect)
    case triangle(Triangle)
    case polygon(Path)
}
