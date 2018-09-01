//
//  UIStoryboard.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 16/08/2018.
//

import UIKit

public extension UIStoryboard {
    /// Instantiate the viewController of the type specified in the return.
    ///
    /// - Parameter identifier: The StoryboardIdentifier of the viewController, if nil, the initialViewController of the UIStoryboard will be instantiated instead.
    /// - Returns: The viewController instantiated (with the identifier, or the initial) of the type specified. Return nil if the type doesnt match.
    public func instantiate<T: UIViewController>(identifier: String?) -> T? {
        func instantiateWithIdentifier() -> Any? {
            if let id = identifier,
                let vc: T = self.instantiateViewController(withIdentifier: id) as? T {
                return vc
            } else {
                return nil
            }
        }
        
        do {
            if identifier != nil,
                let viewController = try Objc.catchException(instantiateWithIdentifier) as? T {
                return viewController
            }
        } catch {
            NSLog("Could not instantiate the viewController with the identifier \"\(identifier ?? "nil")\" from UIStoryboard. Trying to instantiate the initialViewController that matches the requested viewController's Type.")
        }
        return self.instantiateInitialViewController() as? T
    }
}
