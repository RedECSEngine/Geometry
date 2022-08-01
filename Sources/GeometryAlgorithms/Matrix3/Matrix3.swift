import RealModule

public struct Matrix3: ExpressibleByArrayLiteral {
    public private(set) var values: [Double]
    
    public init(values: [Double]) {
        guard values.count == 9 else {
            fatalError("Invalid size for a 3x3 Matrix, must contain exactly 9 elements")
        }
        self.values = values
    }
    
    public init(arrayLiteral elements: Double...) {
        self = Matrix3(values: elements)
    }
    
    subscript(index: Int) -> Double {
        return values[index]
    }
}

public extension Matrix3 {
    static func multiply(_ a: Matrix3, _ b: Matrix3) -> Matrix3 {
        let a00 = a[0 * 3 + 0]
        let a01 = a[0 * 3 + 1]
        let a02 = a[0 * 3 + 2]
        let a10 = a[1 * 3 + 0]
        let a11 = a[1 * 3 + 1]
        let a12 = a[1 * 3 + 2]
        let a20 = a[2 * 3 + 0]
        let a21 = a[2 * 3 + 1]
        let a22 = a[2 * 3 + 2]
        let b00 = b[0 * 3 + 0]
        let b01 = b[0 * 3 + 1]
        let b02 = b[0 * 3 + 2]
        let b10 = b[1 * 3 + 0]
        let b11 = b[1 * 3 + 1]
        let b12 = b[1 * 3 + 2]
        let b20 = b[2 * 3 + 0]
        let b21 = b[2 * 3 + 1]
        let b22 = b[2 * 3 + 2]
        
        return [
            b00 * a00 + b01 * a10 + b02 * a20,
            b00 * a01 + b01 * a11 + b02 * a21,
            b00 * a02 + b01 * a12 + b02 * a22,
            b10 * a00 + b11 * a10 + b12 * a20,
            b10 * a01 + b11 * a11 + b12 * a21,
            b10 * a02 + b11 * a12 + b12 * a22,
            b20 * a00 + b21 * a10 + b22 * a20,
            b20 * a01 + b21 * a11 + b22 * a21,
            b20 * a02 + b21 * a12 + b22 * a22,
        ]
    }
}

public extension Matrix3 {
    static var identity: Matrix3 {
        [
            1, 0, 0,
            0, 1, 0,
            0, 0, 1,
        ]
    }
    
    static func translation(tx: Double, ty: Double) -> Matrix3 {
        [
            1, 0, 0,
            0, 1, 0,
            tx, ty, 1,
        ]
    }
    
    static func rotation(angleInRadians: Double) -> Matrix3 {
        let c = Double.cos(angleInRadians);
        let s = Double.sin(angleInRadians);
        return [
            c,-s, 0,
            s, c, 0,
            0, 0, 1,
        ]
    }
    
    static func scaling(sx: Double, sy: Double) -> Matrix3 {
        [
            sx, 0, 0,
            0, sy, 0,
            0, 0, 1,
        ]
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
}
