//
//  AnyTypes+Utils.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 15/08/2018.
//

import Foundation

//Original source: http://ioschefs.com/swift-get-class-name/
public extension NSObject {
    /// Returns the most specific class name (without the module) of this object.
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    /// Returns the class name (without the module).
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
