//
//  CGRect.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 16/08/18.
//

import UIKit

public let _CSDefaultCGFloat: CGFloat = (CGFloat.greatestFiniteMagnitude - 22.845416) *  -1 //Why this fucking random number out of nowhere? Because i need a default value that must not be nil (and cannot be 0 either). Sorry.

fileprivate func ??(left:CGFloat, right: CGFloat) -> CGFloat {
    return left == _CSDefaultCGFloat ? right : left
}


extension CGPoint: CSVector2Protocol {
    public static func constructFromVector(_ vector: CSVector2) -> CGPoint {
        return CGPoint.init(x: vector.x, y: vector.y)
    }
    
    /// Constructs a new CGPoint struct based on the current values and the new values passed to the method.
    ///
    /// - Parameters:
    ///   - x: The new x property of the CGPoint (default: self.x)
    ///   - y: The new y property of the CGPoint (default: self.y)
    /// - Returns: The CGPoint constructed using the params passed, or self properties if the apropriated param is not passed.
    public func with(x: CGFloat = _CSDefaultCGFloat, y: CGFloat = _CSDefaultCGFloat) -> CGPoint {
        return CGPoint(x: x ?? self.x , y: y ?? self.y)
    }
    
    /// Constructs a new CGPoint struct by adding the values to the current values.
    ///
    /// - Parameters:
    ///   - onX: The value to be added on the x property of the CGPoint (default: 0)
    ///   - onY: The value to be added on the y property of the CGPoint (default: 0)
    /// - Returns: The CGPoint constructed combining self and the params.
    public func adding(onX x: CGFloat = 0, onY y: CGFloat = 0) -> CGPoint {
        return self.with(x: self.x + x, y: self.y + y)
    }
}

extension CGSize: CSVector2Protocol {
    public var x: CSScalar {
        get {
            return self.width
        }
        set {
            self.width = newValue
        }
    }
    
    public var y: CSScalar {
        get {
            return self.height
        }
        set {
            self.height = newValue
        }
    }
    
    public static func constructFromVector(_ vector: CSVector2) -> CGSize {
        return CGSize.init(width: vector.x, height: vector.y)
    }
    
    /// Constructs a new CGSize struct based on the current values and the new values passed to the method.
    ///
    /// - Parameters:
    ///   - width: The new width property of the CGSize (default: self.width)
    ///   - height: The new height property of the CGSize (default: self.height)
    /// - Returns: The CGSize constructed using the params passed, or self properties if the apropriated param is not passed.
    public func with(width: CGFloat = _CSDefaultCGFloat, height: CGFloat = _CSDefaultCGFloat) -> CGSize {        
        return CGSize(width: width ?? self.width, height: height ?? self.height)
    }
    
    /// Constructs a new CGSize struct by adding the values to the current values.
    ///
    /// - Parameters:
    ///   - onWidth: The value to be added on the width property of the CGSize (default: 0)
    ///   - onHeight: The value to be added on the height property of the CGSize (default: 0)
    /// - Returns: The CGSize constructed combining self and the params.
    public func adding(onWidth width: CGFloat = 0, onHeight height: CGFloat = 0) -> CGSize {        
        return self.with(width: self.width + width, height: self.height + height)
    }
}

public extension CGRect {
    /// Constructs a new CGRect struct based on the current values and the new values passed to the method.
    ///
    /// - Parameters:
    ///   - x: The new x property of the CGRect.origin (default: self.x)
    ///   - y: The  new y property of the CGRect.origin (default: self.y)
    ///   - width: The  new width property of the CGRect.size (default: self.width)
    ///   - height: The  new height property of the CGRect.size (default: self.height)
    /// - Returns: The CGSize constructed using the params passed, or self properties if the apropriated param is not passed.
    public func with(x: CGFloat = _CSDefaultCGFloat, y: CGFloat = _CSDefaultCGFloat, width:CGFloat = _CSDefaultCGFloat, height: CGFloat = _CSDefaultCGFloat) -> CGRect {
        return CGRect(x: x ?? self.origin.x, y: y ?? self.origin.y, width: width ?? self.size.width, height: height ?? self.size.height)
    }
    
    /// Constructs a new CGRect struct with the same values of the current rect, but with the size passed on the argument.
    ///
    /// - Parameter size: The new size of the CGRect.
    /// - Returns: A copy of the current CGRect, but with the size specified.
    public func with(size: CGSize) -> CGRect {
        return self.with(width: size.width, height: size.height)
    }
    
    /// Constructs a new CGRect struct with the same values of the current rect, but with the origin passed on the argument.
    ///
    /// - Parameter origin: The new origin of the CGRect.
    /// - Returns: A copy of the current CGRect, but with the origin specified.
    public func with(origin: CGPoint) -> CGRect {
        return self.with(x: origin.x, y: origin.y)
    }
    
    /// Constructs a new CGRect struct by adding the values to the current values.
    ///
    /// - Parameters:
    ///   - onX: The value to be added on the x property of the CGRect.origin (default: 0)
    ///   - onY: The value to be added on the y property of the CGRect.origin (default: 0)
    ///   - width: The value to be added on the width property of the CGRect.size (default: 0)
    ///   - height: The value to be added on the height property of the CGRect.size (default: 0)
    /// - Returns: The CGRect constructed combining self and the params.
    public func adding(onX x: CGFloat = 0, onY y: CGFloat = 0, onWidth width: CGFloat = 0, onHeight height: CGFloat = 0) -> CGRect {
        return self.with(size: self.size.adding(onWidth: width, onHeight: height)).with(origin: self.origin.adding(onX: x, onY: y))
    }
}
