//
//  Sequence+CountWhere.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 16/08/2018.
//

import Foundation

//Original source: https://gist.github.com/khanlou/99066a5a0e9ab59755ef
public extension Sequence {
    /// Verify if any of its elements satisfy a condition.
    ///
    /// - Parameter predicate: The condition applied to the elements.
    /// - Returns: Returns true if the sequence contains an element that satisfy the predicate passed to the method.
    /// - Throws: Rethrows the predicate if needed.
    func any(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            if try predicate(element) {
                return true
            }
        }
        return false
    }
    
    /// Verify if all of its elements satisfy a condition.
    ///
    /// - Parameter predicate: The condition applied to the elements.
    /// - Returns: Returns true if all the elements satisfy the predicate passed to the method.
    /// - Throws: Rethrows the predicate if needed.
    func all(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            if try !predicate(element) {
                return false
            }
        }
        return true
    }
    
    /// Verify if none of its elements satisfy a condition.
    ///
    /// - Parameter predicate: The condition applied to the elements.
    /// - Returns: Returns true if none the elements satisfy the predicate passed to the method.
    /// - Throws: Rethrows the predicate if needed.
    func none(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try !self.any(predicate)
    }
    
    /// Count the number of elements that satisfy a condition.
    ///
    /// - Parameter predicate: The condition applied to the elements.
    /// - Returns: Return the number of elements that satisfy the predicated passed to the method.
    /// - Throws: Rethrows the predicate if needed.
    func count(_ predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }
}

extension Array {
    /// Same as the normal get of element, but before verifies if the index is inside of the bounds of the array, to prevents index out of bounds error.
    ///
    /// - Parameter at: Index of the element to be get.
    /// - Returns: The element at the especified index, or nil if the index is out of bounds.
    public func tryGet(at: Int) -> Element? {
        guard at >= 0 && at < self.count else {return nil}
        return self[at]
    }
    
    /// Same as the normal set of element, but before verifies if the index is inside of the bounds of the array, to prevents index out of bounds error.
    ///
    /// - Parameters:
    ///   - at: Index of the array to set the element.
    ///   - element: The element to be setted at the especified index, if the index is inside the bounds of the array.
    public mutating func trySet(at: Int, _ element: Element) {
        guard at >= 0 && at < self.count else {return}
        self[at] = element
    }
}
