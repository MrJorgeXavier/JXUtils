//
//  UITableView.swift
//  JXUtils
//
//  Created by Jorge Luis on 22/09/2018.
//

import UIKit

extension UITableView {
    /// Dequeues a cell and force cast to the type expected in the return
    ///
    /// - Parameters:
    ///   - indentifier: The identifier used to dequeue the cell (default: class's name of the type expected)
    ///   - indexPath: The indexPath used to discover if is necessary instantiate or reuse a cell.
    /// - Returns: The dequeued and typed cell.
    public func dequeueCell<T: UITableViewCell>(_ indentifier: String = T.className, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: indentifier, for: indexPath) as! T
    }
    
    /// Register the nib associated with the cell (or the cell class if there is no nib associated) in the tableView.
    ///
    /// - Parameters:
    ///   - type: The type of the cell to be registered.
    ///   - nibName: The name of the nib associated with the cell (default: class name of the cell type)
    ///   - identifier: The identifier used to register the cell (default: class name of the cell type)
    ///   - isNib: Indicate if should try to register the nib associated with the cell (default: true)
    public func registerCell<T: UITableViewCell>(_ type: T.Type, nibName: String = T.className, identifier: String = T.className, isNib: Bool = true) {
        if isNib {
            do {
                let nib = try Objc.catchException {
                    return UINib.init(nibName: nibName, bundle: Bundle.init(for: T.classForCoder()))
                } as? UINib
                self.register(nib, forCellReuseIdentifier: identifier)
                return
            } catch {
                NSLog("Could not register cell of type \(T.className) using the nib named \(nibName). Verify if the nib is really valid. Performing the register only for the class of the cell.")
            }
        }
        self.register(T.self, forCellReuseIdentifier: identifier)
    }

    /// Dequeues a cell and force cast to the type expected in the return
    ///
    /// - Parameters:
    ///   - indentifier: The identifier used to dequeue the cell (default: class's name of the type expected)
    /// - Returns: The dequeued and typed cell.
    public func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ identifier: String = T.className) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T
    }
    
    /// Register the nib associated with the headerFooterView (or the headerFooterView class if there is no nib associated) in the tableView.
    ///
    /// - Parameters:
    ///   - type: The type of the headerFooterView to be registered.
    ///   - nibName: The name of the nib associated with the headerFooterView (default: class name of the headerFooterView type)
    ///   - identifier: The identifier used to register the headerFooterView (default: class name of the headerFooterView type)
    ///   - isNib: Indicate if should try to register the nib associated with the headerFooterView (default: true)
    public func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type, nibName: String = T.className, identifier: String = T.className, isNib: Bool = true) {
        if isNib {
            do {
                let nib = try Objc.catchException {
                    return UINib.init(nibName: nibName, bundle: Bundle.init(for: T.classForCoder()))
                } as? UINib
                self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
                return
            } catch {
                NSLog("Could not register headerFooterView of type \(T.className) using the nib named \(nibName). Verify if the nib is really valid. Performing the register only for the class of the headerFooterView.")
            }
        }
        self.register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
