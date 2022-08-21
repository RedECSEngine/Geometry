@testable import Geometry
@testable import GeometryAlgorithms
import GeometrySpriteKitExtensions
import SpriteKit
import XCTest
import SnapshotTesting

final class GeometryAlgorithmsTests: XCTestCase {
    
    func testPointRotation() {
        let point = Point(x: 0, y: 1)
        let rotatedPoint = point.rotated(around: .zero, degrees: 90)
        
        XCTAssertEqual(rotatedPoint.x, 1)
        XCTAssert(rotatedPoint.y.distance(to: 0) < 1e-15) // near-zero precision
    }
    
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
    
    public func testComplexAsteroidPath() throws {
        let points = [
            Point(x:33.5308530375277, y:0.0),
            Point(x:24.12720114175979, y:6.491645172935018),
            Point(x:26.497788903897924, y:16.223513759674326),
            Point(x:17.670262718519385, y:20.698184726988863),
            Point(x:11.907639683235091, y:25.010615144577066),
            Point(x:5.71438631625371, y:30.73413030500584),
            Point(x:-4.381633383105942, y:28.351373542936727),
            Point(x:-10.952139379527821, y:27.459715909672138),
            Point(x:-15.354810356530423, y:21.355163523037323),
            Point(x:-27.742069503211574, y:21.119901311516227),
            Point(x:-23.451394924727875, y:10.222446024172044),
            Point(x:-29.13352407127894, y:6.028743343312282),
            Point(x:-33.417515543224255, y:-0.27059470359851684),
            Point(x:-25.493407712052324, y:-6.86771048470551),
            Point(x:-22.626895229711547, y:-13.889769951189107),
            Point(x:-26.198274241470788, y:-23.29485895082034),
            Point(x:-16.340732659973085, y:-29.336817126789036),
            Point(x:-6.563785807898815, y:-30.62518466198352),
            Point(x:0.6337742497086688, y:-31.517067082378684),
            Point(x:9.4851226086673, y:-32.57102082414351),
            Point(x:17.363999568501747, y:-27.60172618889474),
            Point(x:26.20215885824751, y:-24.608731828737543),
            Point(x:27.78607491824911, y:-16.28416497727599),
            Point(x:28.74071070173692, y:-9.083539200931526)
        ].reversed()
        let path = Path(points: Array(points))
        let scene = SKScene(size: .init(width: 100, height: 100))
        do {
            let triangles = try GeometryAlgorithms.triangulatePolygon(path)
            XCTAssertEqual(triangles.count, points.count - 2)
            add(triangles: triangles, to: scene)
        } catch {
            if let triangulationError = error as? GeometryAlgorithms.TriangulationError,
                case let .cantResolveRemainingVertices(points, triangles) = triangulationError {
                add(shapePoints: points, to: scene)
                add(triangles: triangles, to: scene)
            } else {
                add(shapePoints: Array(points), to: scene)
            }
            XCTFail()
        }

        assertSnapshot(
            matching: scene,
            as: .image(size: .init(width: 100, height: 100))
        )
    }
    
    func testMatrixInversion() {
        func testMatrixInversion() {
            let matrixTranslated = Matrix3
                    .translation(tx: 200, ty: 200)
                    .rotatedBy(angleInRadians: 30.degreesToRadians())
                    .scaledBy(sx: 0.9, sy: 1.2)
            let invertedMatrix = matrixTranslated.calculateInverse()
            XCTAssertEqual(Matrix3.multiply(matrixTranslated, invertedMatrix), .identity)
        }
        
    }
    
}
