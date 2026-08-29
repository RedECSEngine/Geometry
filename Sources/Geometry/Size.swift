import Foundation

public struct Size: Codable, Sendable, Hashable {
    public var width: Double
    public var height: Double
    
    public static let zero: Size = .init(width: 0, height: 0)
    
    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension Size: CustomStringConvertible {
    public var description: String {
        "W:\(width),H:\(height)"
    }
}
