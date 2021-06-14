import Foundation

public enum Direction: String, Codable {
    case up
    case down
    case left
    case right

    public static func fromPoint(_ point: Point) -> Direction {
        let z = atan2(point.x, point.y)
        switch z {
        case 0, -Double.pi / 4, Double.pi / 4:
            return .up
        case Double.pi:
            return .down
        case Double.pi / 2:
            return .right
        case -Double.pi / 2:
            return .left
        default:
            return .down
        }
    }
}
