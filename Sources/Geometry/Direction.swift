import Foundation

public enum Direction: String, Codable {
    case up
    case down
    case left
    case right

    public static func fromPoint(_ point: Point) -> Direction {
        let angle = atan2(point.x, point.y) * (180.0 / Double.pi)
        if angle >= -45, angle < 45 {
            return .up
        } else if angle >= 45, angle < 135 {
            return .right
        } else if angle >= -135, angle < -45 {
            return .left
        } else {
            return .down
        }
    }
}
