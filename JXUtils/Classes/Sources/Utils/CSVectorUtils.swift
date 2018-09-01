//
//  CSVectorUtils.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 15/08/2018.
//
//
//  The core of this file uses the logic of VectorMath from nicklockwood: https://github.com/nicklockwood/VectorMath
//
import Foundation

// MARK: Types
public typealias CSScalar = CGFloat

public struct CSVector2 {
    public var x: CSScalar
    public var y: CSScalar
}

//MARK: CSVector2Protocol methods

/// A protocol that represents an Vector with two dimensions. By conforming to it, the Type become able to perform various algebric operations such as multiplication between vectors. CGPoint and CGSize implements this protocol by default.
public protocol CSVector2Protocol {
    var x: CSScalar {get set}
    var y: CSScalar {get set}
    static func constructFromVector(_ vector: CSVector2) -> Self
}


public prefix func - <T:CSVector2Protocol>(v: T) -> T {
    return -T.constructFromVector(v.vectorRepresentation)
}

public func + <T:CSVector2Protocol>(lhs: T, rhs: CSVector2Protocol) -> T {
    return T.constructFromVector(lhs.vectorRepresentation + rhs.vectorRepresentation)
}

public func - <T:CSVector2Protocol>(lhs: T, rhs: CSVector2Protocol) -> T {
    return T.constructFromVector(lhs.vectorRepresentation - rhs.vectorRepresentation)
}

public func * <T:CSVector2Protocol>(lhs: T, rhs: CSVector2Protocol) -> T {
    return T.constructFromVector(lhs.vectorRepresentation * rhs.vectorRepresentation)
}

public func * <T:CSVector2Protocol>(lhs: T, rhs: CSScalar) -> T {
    return T.constructFromVector(lhs.vectorRepresentation * rhs)
}

public func / <T:CSVector2Protocol>(lhs: T, rhs: CSVector2Protocol) -> T {
    return T.constructFromVector(lhs.vectorRepresentation / rhs.vectorRepresentation)
}

public func / <T:CSVector2Protocol>(lhs: T, rhs: CSScalar) -> T {
    return T.constructFromVector(lhs.vectorRepresentation / rhs)
}

public func == <T:CSVector2Protocol>(lhs: T, rhs: CSVector2Protocol) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

public func ~= <T:CSVector2Protocol>(lhs: T, rhs: CSVector2Protocol) -> Bool {
    return lhs.x ~= rhs.x && lhs.y ~= rhs.y
}

public extension CSVector2Protocol {
    public var vectorRepresentation: CSVector2 { return CSVector2.init(self.x, self.y) }
    
    public var lengthSquared: CSScalar {
        return x * x + y * y
    }
    
    public var length: CSScalar {
        return sqrt(lengthSquared)
    }
    
    public var inverse: Self {
        return -self
    }
    
    public func toArray() -> [CSScalar] {
        return self.vectorRepresentation.toArray()
    }
    
    public func dot(_ v: CSVector2Protocol) -> CSScalar {
        return self.vectorRepresentation.dot(v.vectorRepresentation)
    }
    
    public func cross(_ v: CSVector2Protocol) -> CSScalar {
        return self.vectorRepresentation.cross(v.vectorRepresentation)
    }
    
    public func normalized() -> Self {
        return Self.constructFromVector(self.vectorRepresentation.normalized())
    }
    
    public func rotated(by radians: CSScalar) -> Self {
        let cs = cos(radians)
        let sn = sin(radians)
        return Self.constructFromVector(CSVector2(x * cs - y * sn, x * sn + y * cs))
    }
    
    public func rotated(by radians: CSScalar, around pivot: CSVector2Protocol) -> Self {
        return Self.constructFromVector(self.vectorRepresentation.rotated(by: radians, around: pivot.vectorRepresentation))
    }
    
    public func angle(with v: CSVector2Protocol) -> CSScalar {
        return self.vectorRepresentation.angle(with: v.vectorRepresentation)
    }
    
    public func interpolated(with v: CSVector2Protocol, by t: CSScalar) -> Self {
        return Self.constructFromVector(self.vectorRepresentation.interpolated(with: v.vectorRepresentation, by: t))
    }
}



// MARK: Scalar
extension CSScalar {
    static let halfPi = pi / 2
    static let quarterPi = pi / 4
    static let twoPi = pi * 2
    public static let degreesPerRadian = 180 / pi
    public static let radiansPerDegree = pi / 180
    static let epsilon: CSScalar = 0.0001
    
    public static func ~= (lhs: CSScalar, rhs: CSScalar) -> Bool {
        return Swift.abs(lhs - rhs) < .epsilon
    }
    
    fileprivate var sign: CSScalar {
        return self > 0 ? 1 : -1
    }
}

// MARK: Vector2
extension CSVector2: Hashable {
    public var hashValue: Int {
        return x.hashValue &+ y.hashValue
    }
}

extension CSVector2 {
    static let zero = CSVector2(0, 0)
    static let x = CSVector2(1, 0)
    static let y = CSVector2(0, 1)
    
    var lengthSquared: CSScalar {
        return x * x + y * y
    }
    
    var length: CSScalar {
        return sqrt(lengthSquared)
    }
    
    var inverse: CSVector2 {
        return -self
    }
    
    init(_ x: CSScalar, _ y: CSScalar) {
        self.init(x: x, y: y)
    }
    
    init(_ v: [CSScalar]) {
        assert(v.count == 2, "array must contain 2 elements, contained \(v.count)")
        self.init(v[0], v[1])
    }
    
    func toArray() -> [CSScalar] {
        return [x, y]
    }
    
    func dot(_ v: CSVector2) -> CSScalar {
        return x * v.x + y * v.y
    }
    
    func cross(_ v: CSVector2) -> CSScalar {
        return x * v.y - y * v.x
    }
    
    func normalized() -> CSVector2 {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }
    
    func rotated(by radians: CSScalar) -> CSVector2 {
        let cs = cos(radians)
        let sn = sin(radians)
        return CSVector2(x * cs - y * sn, x * sn + y * cs)
    }
    
    func rotated(by radians: CSScalar, around pivot: CSVector2) -> CSVector2 {
        return (self - pivot).rotated(by: radians) + pivot
    }
    
    func angle(with v: CSVector2) -> CSScalar {
        if self == v {
            return 0
        }
        
        let t1 = normalized()
        let t2 = v.normalized()
        let cross = t1.cross(t2)
        let dot = max(-1, min(1, t1.dot(t2)))
        
        return atan2(cross, dot)
    }
    
    func interpolated(with v: CSVector2, by t: CSScalar) -> CSVector2 {
        return self + (v - self) * t
    }
    
    static prefix func - (v: CSVector2) -> CSVector2 {
        return CSVector2(-v.x, -v.y)
    }
    
    static func + (lhs: CSVector2, rhs: CSVector2) -> CSVector2 {
        return CSVector2(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func - (lhs: CSVector2, rhs: CSVector2) -> CSVector2 {
        return CSVector2(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    static func * (lhs: CSVector2, rhs: CSVector2) -> CSVector2 {
        return CSVector2(lhs.x * rhs.x, lhs.y * rhs.y)
    }
    
    static func * (lhs: CSVector2, rhs: CSScalar) -> CSVector2 {
        return CSVector2(lhs.x * rhs, lhs.y * rhs)
    }
    
    static func / (lhs: CSVector2, rhs: CSVector2) -> CSVector2 {
        return CSVector2(lhs.x / rhs.x, lhs.y / rhs.y)
    }
    
    static func / (lhs: CSVector2, rhs: CSScalar) -> CSVector2 {
        return CSVector2(lhs.x / rhs, lhs.y / rhs)
    }
    
    public static func == (lhs: CSVector2, rhs: CSVector2) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func ~= (lhs: CSVector2, rhs: CSVector2) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y
    }
}
