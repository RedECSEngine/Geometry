import RealModule
import Geometry

public extension GeometryAlgorithms {
    /// https://stackoverflow.com/a/2259502/315623
    /// Rotates clockwise
    static func rotate(
        point: Point,
        around otherPoint: Point,
        degrees: Double
    ) -> Point {
        var p = point - otherPoint
        
        let s = Double.sin(degrees.degreesToRadians())
        let c = Double.cos(degrees.degreesToRadians())

        // rotate point
        let xnew = p.x * c + p.y * s
        let ynew = -p.x * s + p.y * c
        
        // translate point back:
        p.x = xnew + otherPoint.x
        p.y = ynew + otherPoint.y
        return p
    }
}

public extension Point {
    func rotated(around otherPoint: Point, degrees: Double) -> Point {
        GeometryAlgorithms.rotate(
            point: self,
            around: otherPoint,
            degrees: degrees
        )
    }
}

public extension Triangle {
    func rotated(around pivotPoint: Point, degrees: Double) -> Triangle {
        return Triangle(
            a: a.rotated(around: pivotPoint, degrees: degrees),
            b: b.rotated(around: pivotPoint, degrees: degrees),
            c: c.rotated(around: pivotPoint, degrees: degrees)
        )
    }
}
