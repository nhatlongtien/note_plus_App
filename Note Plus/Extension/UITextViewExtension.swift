//
//  UITextViewExtension.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/11/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
extension UITextView{
    func addDoneButtonOnKeyboard(){
        let doneToobar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToobar.items = items
        doneToobar.sizeToFit()
        self.inputAccessoryView = doneToobar
    }
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
}
