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
    }
    
   
    
    @IBAction func lockBtnWasPressed(_ sender: Any) {
        let managedObjectContext = AppDelegate.managedObjectContext
        if lockBtn.currentTitle == "UNLOCK"{
            noteSelected?.lockStatus = false
            noteSelected?.content = noteContentTextView.text
            noteSelected?.createDate = Date()
            self.lockBtn.setTitle("LOCK", for: .normal)
        }else{
            noteSelected?.lockStatus = true
            noteSelected?.content = noteContentTextView.text
            noteSelected?.createDate = Date()
            self.lockBtn.setTitle("UNLOCK", for: .normal)
        }
        do{
            try managedObjectContext?.save()
            self.dismiss(animated: true, completion: nil)
        }catch{
            print("Error to upade lock status of this note")
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
