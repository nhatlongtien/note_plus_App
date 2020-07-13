//
//  DetailNote.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/10/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DetailNote: UIViewController {
    var selectedNote:Note?
    @IBOutlet weak var noteContentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        noteContentTextView.isEditable = false
        noteContentTextView.text = selectedNote?.content
    }
    
    @IBAction func backBtnWasPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
