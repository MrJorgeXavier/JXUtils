//
//  UIView+FromNib.swift
//  CupertinoStandards
//
//  Created by Jorge Luis on 15/08/2018.
//

import UIKit

public extension UIView {
    /// This method instantiate the view by loading the nib with the same name of the view's class used to call this method.
    ///
    /// - Parameters:
    ///   - nibName: NibName passed to the UINib.init(nibName:,bundle:). Default: view's className
    ///   - owner: FileOwner passed to the UINib().instantiate(withOwner:Any?, options: [AnyHashable:Any]?) method. Default: nil
    ///   - options: Options passed on UINib().instantiate(withOwner:Any?, options: [AnyHashable:Any]?) method. Default: nil
    /// - Returns: The view object loaded from Nib file associated with the class`s name and class`s Bundle.
    public class func fromNib(nibName: String? = nil, owner: Any? = nil, options: [AnyHashable: Any]? = nil) -> Self {
        return self.fromNibFile(nibName: nibName ?? self.className, owner:owner, options:options)
    }
    
    /// Sets itself as subview of the argument passed in the parameter, and then sets its contraints to match top, bottom, right and left of the superview.
    ///
    /// - Parameter view: The view which this view will be constrained. If this view's superview is nil, this parameter will become this view's superview
    public func embed(in view:UIView) {
        if self.superview == nil {
            view.addSubview(self)
        }
        self.constrain(to: view)
    }
    
    /// Sets its constraints to match the view's top, left, right and bottom anchors.
    ///
    /// - Parameter view: The target view to match the constraints
    /// - Returns: The constraints added and activated, in the order: left, top, right, bottom.
    @discardableResult
    public func constrain(to view: UIView) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    
}


extension UIView {    
    class func fromNibFile<T:UIView>(nibName: String, owner: Any?, options: [AnyHashable: Any]?) -> T {
        let bundle = Bundle.init(for: T.classForCoder())
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: owner, options: options).first(where: {$0 is T}) as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view as! T
    }
}
