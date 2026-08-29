import Geometry
import RealModule

public extension GeometryAlgorithms {
    static func triangulateLine(_ line: Line, lineWidth: Double) -> [Triangle] {
        let a = line.a
        let b = line.b
        
        // Direction vector along the line
        let dx = b.x - a.x
        let dy = b.y - a.y
        let length = (dx * dx + dy * dy).squareRoot()
        
        guard length > 0 else { return [] }
        
        // Unit direction vector
        let ux = dx / length
        let uy = dy / length
        
        // Perpendicular = rotate the direction 90°
        let halfWidth = lineWidth / 2.0
        let px = -uy * halfWidth
        let py =  ux * halfWidth
        
        // Four corners of the rectangle (a quad) that represents the thick line
        let startLeft  = Point(x: a.x + px, y: a.y + py)
        let startRight = Point(x: a.x - px, y: a.y - py)
        let endLeft    = Point(x: b.x + px, y: b.y + py)
        let endRight   = Point(x: b.x - px, y: b.y - py)
        
        // Split the quad into two triangles along the startRight→endLeft diagonal
        return [
            Triangle(a: startLeft,  b: startRight, c: endLeft),
            Triangle(a: startRight, b: endRight,   c: endLeft)
        ]
    }
}
      
