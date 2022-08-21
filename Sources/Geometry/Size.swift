import Foundation

public struct Size: Codable {
    public var width: Double
    public var height: Double
    
    public static var zero: Size = .init(width: 0, height: 0)
    
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

extension Size: Equatable {}

public func == (_ lhs: Size, _ rhs: Size) -> Bool {
    lhs.width == rhs.width && lhs.height == rhs.height
}

extension Size: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}
