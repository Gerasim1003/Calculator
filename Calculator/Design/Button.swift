//
//  Button.swift
//  Calculator
//
//  Created by Gerasim Israyelyan on 5/29/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    override func prepareForInterfaceBuilder() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
}
