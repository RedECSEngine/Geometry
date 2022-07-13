import Geometry

public extension GeometryAlgorithms {
    enum TriangulationError: Error {
        case cantResolveVertices
    }
        
    static func triangulatePolygon(_ path: Path) throws -> [Triangle] {
        guard path.points.count >= 3 else { return [] }
        
        var vertices = path.points
        var triangles: [Triangle] = []
        
        var index: Int = -1
        vertexLoop: while vertices.count > 3 {
            index += 1
            
            if index >= vertices.count {
                if triangles.isEmpty {
                    throw TriangulationError.cantResolveVertices
                }
                index = 0
            }
            
            let vertexPrev = vertices[prevIndex(from: index, count: vertices.count)]
            let vertexCurrent = vertices[index]
            let vertexNext = vertices[nextIndex(from: index, count: vertices.count)]
            
            // check angle is < 180 with cross product
            let v1 = vertexPrev - vertexCurrent
            let v2 = vertexNext - vertexCurrent
            
            let crossProduct = crossProduct(v1, b: v2)
            if crossProduct < 0 {
                continue vertexLoop
            }
            
            let triangle = Triangle(
                a: vertexPrev,
                b: vertexCurrent,
                c: vertexNext
            )
            // check no other vertex inside this triangle
            containmentCheckLoop: for vertex in vertices {
                guard vertex != vertexPrev,
                      vertex != vertexCurrent,
                      vertex != vertexNext else {
                    continue containmentCheckLoop
                }
                guard !triangle.contains(vertex) else {
                    continue vertexLoop
                }
            }
            
            triangles.append(triangle)
            vertices.remove(at: index)
            index -= 1
        }
        
        triangles.append(Triangle(
            a: vertices[0],
            b: vertices[1],
            c: vertices[2]
        ))
        
        return triangles
    }
    
    private static func prevIndex(from index: Int, count: Int) -> Int {
        if index - 1 < 0 {
            return count - 1
        }
        return index - 1
    }
    
    
    private static func nextIndex(from index: Int, count: Int) -> Int {
        if index + 1 >= count {
            return 0
        }
        return index + 1
    }
}
