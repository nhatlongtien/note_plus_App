//
//  UIButtonExtension.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
extension UIButton{
    func setSelectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.08926493675, green: 0.6886711121, blue: 0.2516648173, alpha: 0.7018139983)
    }
    func setDeSelectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.08926493675, green: 0.6886711121, blue: 0.2516648173, alpha: 1)
    }
}
