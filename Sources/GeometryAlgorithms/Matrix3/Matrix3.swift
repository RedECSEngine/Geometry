import RealModule
import Geometry

public struct Matrix3: ExpressibleByArrayLiteral, Hashable, Sendable {
    private var m00, m01, m02: Double
    private var m10, m11, m12: Double
    private var m20, m21, m22: Double

    private init(
        _ m00: Double, _ m01: Double, _ m02: Double,
        _ m10: Double, _ m11: Double, _ m12: Double,
        _ m20: Double, _ m21: Double, _ m22: Double
    ) {
        self.m00 = m00
        self.m01 = m01
        self.m02 = m02
        self.m10 = m10
        self.m11 = m11
        self.m12 = m12
        self.m20 = m20
        self.m21 = m21
        self.m22 = m22
    }

    public var values: [Double] {
        [m00, m01, m02, m10, m11, m12, m20, m21, m22]
    }

    public init(values: [Double]) {
        guard values.count == 9 else {
            fatalError("Invalid size for a 3x3 Matrix, must contain exactly 9 elements")
        }
        self.init(
            values[0], values[1], values[2],
            values[3], values[4], values[5],
            values[6], values[7], values[8]
        )
    }

    public init(arrayLiteral elements: Double...) {
        self = Matrix3(values: elements)
    }

    subscript(index: Int) -> Double {
        switch index {
        case 0: return m00
        case 1: return m01
        case 2: return m02
        case 3: return m10
        case 4: return m11
        case 5: return m12
        case 6: return m20
        case 7: return m21
        case 8: return m22
        default: fatalError("Matrix3 index out of range: \(index)")
        }
    }
}

public extension Matrix3 {
    static func multiply(_ a: Matrix3, _ b: Matrix3) -> Matrix3 {
        Matrix3(
            b.m00 * a.m00 + b.m01 * a.m10 + b.m02 * a.m20,
            b.m00 * a.m01 + b.m01 * a.m11 + b.m02 * a.m21,
            b.m00 * a.m02 + b.m01 * a.m12 + b.m02 * a.m22,
            b.m10 * a.m00 + b.m11 * a.m10 + b.m12 * a.m20,
            b.m10 * a.m01 + b.m11 * a.m11 + b.m12 * a.m21,
            b.m10 * a.m02 + b.m11 * a.m12 + b.m12 * a.m22,
            b.m20 * a.m00 + b.m21 * a.m10 + b.m22 * a.m20,
            b.m20 * a.m01 + b.m21 * a.m11 + b.m22 * a.m21,
            b.m20 * a.m02 + b.m21 * a.m12 + b.m22 * a.m22
        )
    }
}

public extension Matrix3 {
    static var identity: Matrix3 {
        Matrix3(
            1, 0, 0,
            0, 1, 0,
            0, 0, 1
        )
    }

    static func translation(tx: Double, ty: Double) -> Matrix3 {
        Matrix3(
            1, 0, 0,
            0, 1, 0,
            tx, ty, 1
        )
    }

    static func rotation(angleInRadians: Double) -> Matrix3 {
        let c = Double.cos(angleInRadians)
        let s = Double.sin(angleInRadians)
        return Matrix3(
            c, -s, 0,
            s, c, 0,
            0, 0, 1
        )
    }

    static func scaling(sx: Double, sy: Double) -> Matrix3 {
        Matrix3(
            sx, 0, 0,
            0, sy, 0,
            0, 0, 1
        )
    }
}

public extension Matrix3 {
    func translatedBy(tx: Double, ty: Double) -> Self {
        .multiply(self, .translation(tx: tx, ty: ty))
    }

    func rotatedBy(angleInRadians: Double) -> Self {
        .multiply(self, .rotation(angleInRadians: angleInRadians))
    }

    func scaledBy(sx: Double, sy: Double) -> Self {
        .multiply(self, .scaling(sx: sx, sy: sy))
    }

    func calculateInverse() -> Self {
        let b01 = m22 * m11 - m12 * m21
        let b11 = -m22 * m10 + m12 * m20
        let b21 = m21 * m10 - m11 * m20

        let det = m00 * b01 + m01 * b11 + m02 * b21

        return Matrix3(
            b01 / det, (-m22 * m01 + m02 * m21) / det, (m12 * m01 - m02 * m11) / det,
            b11 / det, (m22 * m00 - m02 * m20) / det, (-m12 * m00 + m02 * m10) / det,
            b21 / det, (-m21 * m00 + m01 * m20) / det, (m11 * m00 - m01 * m10) / det
        )
    }
}

public extension Point {
    func multiplyingMatrix(_ matrix: Matrix3) -> Point {
        let cx = (matrix[0] * x) + (matrix[3] * y) + matrix[6]
        let cy = (matrix[1] * x) + (matrix[4] * y) + matrix[7]
        let cw = (matrix[2] * x) + (matrix[5] * y) + matrix[8]
        return Point(x: cx / cw, y: cy / cw)
    }
}

public extension Triangle {
    func multiplyingMatrix(_ matrix: Matrix3) -> Triangle {
        Triangle(
            a: a.multiplyingMatrix(matrix),
            b: b.multiplyingMatrix(matrix),
            c: c.multiplyingMatrix(matrix)
        )
    }
}
