//
//  CreateNoteVC.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class CreateNoteVC: UIViewController, UITextViewDelegate{
    var lockStatus:statusLock?
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var lockNoteBtn: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lockNoteBtn.setTitle("LOCK", for: .normal)
        lockStatus = .lockOn
        //
        noteContentTextView.addDoneButtonOnKeyboard()
    }

    @IBAction func lockNoteBtnWasPressed(_ sender: Any) {
        if lockStatus == statusLock.lockOff{
            lockNoteBtn.setTitle("LOCK", for: .normal)
            lockStatus = statusLock.lockOn
        }else{
            lockNoteBtn.setTitle("UNLOCK", for: UIControl.State.normal)
            lockStatus = statusLock.lockOff
        }
    }
    @IBAction func createNoteBtnWasPressed(_ sender: Any) {
        var status:Bool?
        if lockStatus == statusLock.lockOn{
            status = true
        }else{
            status = false
        }
        Note.instance.insertNewNote(noteContent: noteContentTextView.text, lockStatus: status!) { (success) in
            if success{
                print("Inert new note successfully")
                self.performSegue(withIdentifier: "unwindToTakeNoteVC", sender: nil)
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToTakeNoteVC", sender: nil)
    }
    // MARK: - Helper Method
    
    
    
}
