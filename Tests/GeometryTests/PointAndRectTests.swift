@testable import Geometry
import SpriteKit
import XCTest
import GeometrySpriteKitExtensions

final class PointAndRectTests: XCTestCase {
    func testShouldNotContainThePoint() {
        let rect1 = Rect(x: 0, y: 0, width: 4, height: 4)
        let point1 = Point(x: 4, y: 4)
        let point2 = Point(x: 5, y: 5)
        let point3 = Point(x: 4, y: 0)
        let point4 = Point(x: 0, y: 4)

        XCTAssertEqual(rect1.contains(point1), false)
        XCTAssertEqual(rect1.contains(point2), false)
        XCTAssertEqual(rect1.contains(point3), false)
        XCTAssertEqual(rect1.contains(point4), false)

        XCTAssertEqual(rect1.makeCGRect().contains(point1.makeCGPoint()), false)
        XCTAssertEqual(rect1.makeCGRect().contains(point2.makeCGPoint()), false)
        XCTAssertEqual(rect1.makeCGRect().contains(point3.makeCGPoint()), false)
        XCTAssertEqual(rect1.makeCGRect().contains(point4.makeCGPoint()), false)
    }

    func testShouldContainThePoint() {
        let rect1 = Rect(x: 0, y: 0, width: 4, height: 4)
        let point1 = Point(x: 0, y: 0)
        let point2 = Point(x: 1, y: 0)
        let point3 = Point(x: 0, y: 1)

        XCTAssertEqual(rect1.contains(point1), true)
        XCTAssertEqual(rect1.contains(point2), true)
        XCTAssertEqual(rect1.contains(point3), true)

        XCTAssertEqual(rect1.makeCGRect().contains(point1.makeCGPoint()), true)
        XCTAssertEqual(rect1.makeCGRect().contains(point2.makeCGPoint()), true)
        XCTAssertEqual(rect1.makeCGRect().contains(point3.makeCGPoint()), true)
    }

    func testShouldNotEvaluateRectsAsIntersecting() {
        let rect1 = Rect(x: 0, y: 0, width: 4, height: 4)
        let rect2 = Rect(x: 5, y: 5, width: 4, height: 4)
        let rect3 = Rect(x: -2, y: -2, width: 4, height: 2)
        let rect4 = Rect(x: -2, y: 0, width: 2, height: 2)
        let rect5 = Rect(x: 4, y: 0, width: 4, height: 4)

        XCTAssertEqual(rect1.intersects(rect2), false)
        XCTAssertEqual(rect1.intersects(rect3), false)
        XCTAssertEqual(rect1.intersects(rect4), false)
        XCTAssertEqual(rect1.intersects(rect5), false)

        XCTAssertEqual(rect1.makeCGRect().intersects(rect2.makeCGRect()), false)
        XCTAssertEqual(rect1.makeCGRect().intersects(rect3.makeCGRect()), false)
        XCTAssertEqual(rect1.makeCGRect().intersects(rect5.makeCGRect()), false)
    }

    func testShouldEvaluateRectsAsIntersecting() {
        let rect1 = Rect(x: 0, y: 0, width: 4, height: 4)
        let rect2 = Rect(x: 1, y: 1, width: 4, height: 4)
        let rect3 = Rect(x: 3, y: 2, width: 4, height: 2)
        let rect4 = Rect(x: 1, y: 1, width: 1, height: 1)

        XCTAssertEqual(rect1.intersects(rect2), true)
        XCTAssertEqual(rect1.intersects(rect3), true)
        XCTAssertEqual(rect1.intersects(rect4), true)

        XCTAssertEqual(rect1.makeCGRect().intersects(rect2.makeCGRect()), true)
        XCTAssertEqual(rect1.makeCGRect().intersects(rect3.makeCGRect()), true)
        XCTAssertEqual(rect1.makeCGRect().intersects(rect4.makeCGRect()), true)
    }
}
