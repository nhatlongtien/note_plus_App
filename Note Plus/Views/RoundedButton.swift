//
//  RoundedButton.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var radius:CGFloat = 3.0
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

}
