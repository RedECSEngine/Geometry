@testable import Geometry
import SpriteKit
import XCTest

final class LineIntersectionTests: XCTestCase {
    
    func testLineAndCircleIntersection() {
        let line1 = Line(a: .init(x: 0, y: 1), b: .init(x: 3, y: 0))
        let circle1 = Circle(center: .zero, radius: 2)
        XCTAssertEqual(line1.intersects(circle1), true)

        let line2 = Line(a: .init(x: 0, y: 5), b: .init(x: 5, y: 0))
        let circle2 = Circle(center: .zero, radius: 2)
        XCTAssertEqual(line2.intersects(circle2), false)

        let line3 = Line(a: .init(x: 0, y: 2), b: .init(x: 2, y: 0))
        let circle3 = Circle(center: .zero, radius: 3)
        XCTAssertEqual(line3.intersects(circle3), true)
        
        let line4 = Line(a: .init(x: 0, y: 3), b: .init(x: 0, y: 2))
        let circle4 = Circle(center: .zero, radius: 2)
        XCTAssertEqual(line4.intersects(circle4), true)
    }
    
}
