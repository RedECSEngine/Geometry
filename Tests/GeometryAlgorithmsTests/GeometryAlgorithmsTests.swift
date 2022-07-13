@testable import Geometry
@testable import GeometryAlgorithms
import GeometrySpriteKitExtensions
import SpriteKit
import XCTest
import SnapshotTesting

final class GeometryAlgorithmsTests: XCTestCase {
    
    func testShipTriangulation() throws {
        let path = Path(points: [
            .init(x: -10, y: 0),
            .init(x: 0, y: 20),
            .init(x: 10, y: 0),
            .init(x: 0, y: 6),
        ])
        
        let triangles = try GeometryAlgorithms.triangulatePolygon(path)
        
        XCTAssertEqual(triangles.count, 2)
        XCTAssertEqual(triangles[0], .init(
            a: .init(x: 0, y: 6),
            b: .init(x: -10, y: 0),
            c: .init(x: 0, y: 20)
        ))
        XCTAssertEqual(triangles[1], .init(
            a: .init(x: 0, y: 20),
            b: .init(x: 10, y: 0),
            c: .init(x: 0, y: 6)
        ))
        
        let scene = SKScene(size: .init(width: 100, height: 100))
        for triangle in triangles {
            let shape = SKShapeNode(path: triangle.makeCGPath())
            shape.position = .init(x: 50, y: 50)
            scene.addChild(shape)
        }
        assertSnapshot(
            matching: scene,
            as: .image(size: .init(width: 100, height: 100))
        )
    }
    
    func testShellTriangulation() throws {
        let edges = 24
        let path = createShellPath(edges: edges)
        let triangles = try GeometryAlgorithms.triangulatePolygon(path)
        XCTAssertEqual(triangles.count, edges - 2)
        
        let scene = SKScene(size: .init(width: 100, height: 100))
        for triangle in triangles {
            let shape = SKShapeNode(path: triangle.makeCGPath())
            shape.position = .init(x: 50, y: 50)
            scene.addChild(shape)
        }
        assertSnapshot(
            matching: scene,
            as: .image(size: .init(width: 100, height: 100))
        )
    }
    
    private func createShellPath(edges: Int) -> Path {
        let angleIncrement = 360 / Double(edges)
        var points: [Point] = []
        var angle: Double = 0
        for i in 0..<edges {
            let edgeRadius: Double = Double(10 + i)
            let x = edgeRadius * cos(angle.degreesToRadians())
            let y = edgeRadius * sin(angle.degreesToRadians())
            points.append(Point(x: x, y: y))
            angle -= angleIncrement
        }
        return Path(points: points)
    }
    
    func testAsteroidTriangulation() throws {
        let edges = 24
        let path = createAsteroidPath(edges: edges)
        let scene = SKScene(size: .init(width: 100, height: 100))
        
        let triangles = try GeometryAlgorithms.triangulatePolygon(path)
        XCTAssertEqual(triangles.count, edges - 2)
        
        add(triangles: triangles, to: scene)
        
        
        XCTAssertEqual(triangles.count, path.points.count - 2)
        assertSnapshot(
            matching: scene,
            as: .image(size: .init(width: 100, height: 100))
        )
    }
    
    private func add(triangles: [Triangle], to scene: SKScene) {
        for triangle in triangles {
            let shape = SKShapeNode(path: triangle.makeCGPath())
            shape.position = .init(x: 50, y: 50)
            shape.fillColor = SKColor(red: 1, green: 1, blue: 1, alpha: 0.33)
            scene.addChild(shape)
        }
    }
    
    private func add(shapePoints: [Point], to scene: SKScene) {
        let path = Path(points: shapePoints)
        let shape = SKShapeNode(path: path.makeCGPath())
        shape.position = .init(x: 50, y: 50)
        shape.fillColor = SKColor(red: 1, green: 1, blue: 1, alpha: 0.33)
        scene.addChild(shape)
    }
    
    private func createAsteroidPath(edges: Int) -> Path {
        let angleIncrement = 360 / Double(edges)
        var points: [Point] = []
        var angle: Double = 0
        for i in 0..<edges {
            var edgeRadius: Double = 20
            switch i % 3 {
            case 0:
                edgeRadius += 2
            case 1:
                edgeRadius += 0
            case 2:
                edgeRadius += 4
            default:
                edgeRadius += 0
            }
            let x = edgeRadius * cos(angle.degreesToRadians())
            let y = edgeRadius * sin(angle.degreesToRadians())
            points.append(Point(x: x, y: y))
            angle -= angleIncrement
        }
        return Path(points: points)
    }
    
}
