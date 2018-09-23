//
//  ViewController.swift
//  JXUtils
//
//  Created by oojlxavier@gmail.com on 09/01/2018.
//  Copyright (c) 2018 oojlxavier@gmail.com. All rights reserved.
//

import UIKit
import JXUtils

enum Options: String {
    case alert = "Present Alert"
    case gradient = "ShowGradient"
    case fromNib = "Instantiate From Nib"
    case fromStoryboard = "Instantiate From Storyboard"
    case className = "Class Name"
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var options: [Options] = [
        .alert, .gradient, .fromNib, .fromStoryboard, .className
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.tableView.registerCell(CustomTableViewCell.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.titleLabel.text = self.options[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = self.options[indexPath.row]
        switch option {
        case .alert:
            self.presentAlert()
        case .gradient:
            self.presentGradient()
        case .fromNib:
            self.presentFromNib()
        case .fromStoryboard:
            self.presentFromStoryboard()
        case .className:
            self.presentClassName()
        }
    }
    
    
    
    
    //MARK: TEST METHODS:
    func presentAlert() {
        self.showMessage(message: "This is a test")
    }
    
    func presentGradient() {
        self.view.layer.insertGradient(with: [.red, .black], distribution: .equally)
    }
    
    func presentFromNib() {
        let _view = CustomView.fromNib()
        _view.frame = self.view.frame.insetBy(dx: 50, dy: 100)
        self.view.addSubview(_view)
        UIView.animate(withDuration: 3, animations: {
            _view.alpha = 0
        }) { (_) in
            _view.removeFromSuperview()
        }
    }
    
    func presentFromStoryboard() {
        let viewController = CustomViewController.fromStoryboard()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentClassName() {
        print("self.className: ",self.className)
        print("CustomViewController.className: ", CustomViewController.className)
    }
}

