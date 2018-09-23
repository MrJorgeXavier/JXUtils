//
//  UIViewContorller+Utils.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 15/08/2018.
//

import UIKit


//TODO: MAKE THIS SHIT INSTANCE
public struct CSUIViewControllerSettings {
    //MARK: Default defined values:
    
    public static var closeButtonTitle: String = "Fechar"
    public static var cancelButtonTitle: String = "Cancelar"
    
    //MARK: Default defined factories:
    
    /// The 'factory' of the default action button used in the showMessage method. (title Attention, handler nil)
    public static var defaultAlertCloseAction: (() -> UIAlertAction)  = {
        return UIAlertAction.init(title: CSUIViewControllerSettings.closeButtonTitle, style: .default, handler: nil)
    }
    
    /// The 'factory' of the default cancel button used in the showMessage method. (title Close, handler nil)
    public static var defaultAlertCancelAction: (() -> UIAlertAction)  = {
        return UIAlertAction.init(title: CSUIViewControllerSettings.cancelButtonTitle, style: .default, handler: nil)
    }
    
    /// The pattern used to obtain the storyboard name of a given UIViewController's type (default: viewController.className).
    public static var storyboardNamingConventionPattern: ((_ viewController: UIViewController.Type) -> String) = { vc in
        return vc.className.components(separatedBy:"ViewController").first!
    }

}

public extension UIViewController {
    /// Present an UIAlertController with the params passed on the call.
    ///
    /// - Parameters:
    ///   - hasCancel: If true, adds a cancel button with the title of the AlertSettings.defaultCancelButtonTitle (default: false).
    ///   - title: The title used on the alert (default: nil)
    ///   - message: The message used on the alert.
    ///   - closeAction: The UIAlertAction used on the close button of the alert( default: UIAlertAction.init(title: AlertSettings.defaultMainButtonTitle, style: .default, handler: nil))
    public func showMessage(title: String? = nil, message: String, closeAction: UIAlertAction = CSUIViewControllerSettings.defaultAlertCloseAction(), hasCancel: Bool = false) {
        var actions = [closeAction]
        if hasCancel {
            actions.append(CSUIViewControllerSettings.defaultAlertCloseAction())
        }
        self.showAlert(title: title, message: message, actions: actions)
    }
    
    /// Present an UIAlertController with the params passed on the call.
    ///
    /// - Parameters:
    ///   - style: UIAlerControllerStyle used in the UIAlertController.init(title:,message:,preferredStyle:)
    ///   - title: UIAlerControllerStyle used in the UIAlertController.init(title:,message:,preferredStyle:)
    ///   - message: UIAlerControllerStyle used in the UIAlertController.init(title:,message:,preferredStyle:)
    ///   - actions: UIAlertActions added to the UIAlertController that will be presented.
    ///   - completion: completion block passed on the viewController`s present(_:,animated:,completion:) method.
    public func showAlert(title: String?, message: String?, actions: [UIAlertAction], style: UIAlertControllerStyle = .alert, _ completion: os_block_t? = nil) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: style)
        for action in actions {
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: completion)
    }
    
    /// Instantiate the viewController by loading it from the storyboard.
    /// - ATTENTION:
    ///     - The viewController inside the storyboard MUST have an StoryboardIdentifier, by default is considered the className of the viewController.
    ///     
    /// - Parameters:
    ///   - storyboardName: The name of the storyboard file which the viewController is (default: CSUIViewControllerSettings.storyboardNamingConventionPattern())
    ///   - identifier: The identifier of the viewController inside of the storyboard (default: viewController.className).
    /// - Returns: The viewController instantiated.
    public class func fromStoryboard(storyboardName: String? = nil, identifier: String? = nil) -> Self {
        if let name = storyboardName {
            return self.fromStoryboardFile(storyboardName: name, identifier: identifier ?? self.className)
        } else {
            return self.fromStoryboardFile(identifier: identifier ?? self.className)
        }
    }
    
    /// Instantiate the navigationController by loading it from the storyboard.
    ///
    /// - Parameters:
    ///   - storyboardName: The name of the storyboard file which the viewController is (default: CSUIViewControllerSettings.storyboardNamingConventionPattern())
    ///   - identifier: The identifier of the viewController inside of the storyboard (default: nil, witch means the viewController instantiated will be the initialViewController)
    /// - Returns: the NavigationController instantiated.
    public class func fromStoryboardWithNavigationController(storyboardName: String? = nil, identifier: String? = nil) -> UINavigationController {
        let bundle = Bundle.init(for: self.classForCoder())
        let storyboard = UIStoryboard.init(name: storyboardName ?? CSUIViewControllerSettings.storyboardNamingConventionPattern(self), bundle: bundle)
        return storyboard.instantiate(identifier: identifier) as! UINavigationController
    }
    
}


extension UIViewController {
    class func fromStoryboardFile<T: UIViewController>(storyboardName: String = CSUIViewControllerSettings.storyboardNamingConventionPattern(T.self), identifier: String?) -> T {
        let bundle = Bundle.init(for: T.classForCoder())
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: bundle)
        return storyboard.instantiate(identifier: identifier) as! T
    }
}
