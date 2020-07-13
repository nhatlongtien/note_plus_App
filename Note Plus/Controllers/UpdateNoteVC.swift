//
//  DetailNoteVC.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class UpdateNoteVC: UIViewController {
    var noteSelected:Note?
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var lockBtn: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: noteSelected!)
        noteContentTextView.addDoneButtonOnKeyboard()
    }
    
    @IBAction func lockBtnWasPressed(_ sender: Any) {
        if lockBtn.currentTitle == "UNLOCK"{
            noteSelected?.lockStatus = false
            self.lockBtn.setTitle("LOCK", for: .normal)
        }else{
            noteSelected?.lockStatus = true
            self.lockBtn.setTitle("UNLOCK", for: .normal)
        }
    }
    @IBAction func updateBtnWasPressed(_ sender: Any) {
        let managedObjectcontext = AppDelegate.managedObjectContext
        self.noteSelected?.content = noteContentTextView.text
        self.noteSelected?.createDate = Date()
        do{
            try managedObjectcontext?.save()
            self.dismiss(animated: true, completion: nil)
        }catch{
            print("Can not update this note")
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setupView(with note:Note){
        noteContentTextView.text = note.content
        if note.lockStatus == true{
            self.lockBtn.setTitle("UNLOCK", for: .normal)
        }else{
            self.lockBtn.setTitle("LOCK", for: .normal)
        }
    }
    
}
