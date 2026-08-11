import Geometry
import RealModule

public extension GeometryAlgorithms {
    static func triangulateCircle(_ circle: Circle, slices: Int? = nil) -> [Triangle] {
        let numSlices: Int
        if let slices = slices {
            numSlices = slices
        } else {
            // From random testing these seem to make good mins and maxes for rending purposes
            numSlices = Int(min(max(12, circle.radius), 72))
        }
        
        let degreeIncrements: Double = 360 / Double(numSlices)
        
        let triangles = (0..<numSlices).map { slice -> Triangle in
            let slice = Double(slice)
            let vertBDegrees = slice * degreeIncrements
            let vertCDegrees = (slice + 1) * degreeIncrements
            
            let a = Point(x: circle.center.x, y: circle.center.y)
            let b = Point(
                x: Double.cos(vertBDegrees.degreesToRadians()) * circle.radius,
                y: -Double.sin(vertBDegrees.degreesToRadians()) * circle.radius
            ) + circle.center
            let c = Point(
                x: Double.cos(vertCDegrees.degreesToRadians()) * circle.radius,
                y: -Double.sin(vertCDegrees.degreesToRadians()) * circle.radius
            ) + circle.center
            return Triangle(a: a, b: b, c: c)
        }
        return triangles
    }
}
