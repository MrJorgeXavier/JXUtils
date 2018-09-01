//
//  UIDevice.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 16/08/2018.
//

import UIKit

public extension UIDevice {
    
    /// Returns true if the device is an iPhone, false otherwise.
    public  static func isPhone() -> Bool {
        return current.userInterfaceIdiom == .phone
    }

    /// Returns true if the device is an iPad, false otherwise.
    public static func isPad() -> Bool {
        return current.userInterfaceIdiom == .pad
    }
    
    /// Returns true if the device is currently in portrait orientation.
    public static func isPortrait() -> Bool {
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        return UIInterfaceOrientationIsPortrait(orientation)
    }
    
    /// Returns true if the device is currently in landscape orientation.
    public static func isLandscape() -> Bool {
        return !self.isPortrait()
    }

}
