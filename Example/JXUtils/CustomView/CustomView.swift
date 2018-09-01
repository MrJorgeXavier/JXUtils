//
//  CustomView.swift
//  CupertinoStandards_Example
//
//  Created by Jorge Luis on 21/08/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import JXUtils

class CustomView: UIView {
    weak var gradient: CAGradientLayer?
    
    override func awakeFromNib() {
        self.gradient = self.layer.insertGradient(with: [UIColor.green,UIColor.yellow])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient?.frame = self.layer.bounds
    }
}
