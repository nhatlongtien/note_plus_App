//
//  TakeNoteVC.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import LocalAuthentication
class TakeNoteVC: UIViewController {
    var notes = [Note]()
    var selectedNote:Note?
    @IBOutlet weak var tableView: UITableView!
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        Note.instance.getAllNote { (results) in
            self.notes = results
            if self.notes.count == 0{
                self.tableView.isHidden = true
            }else{
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func addNoteBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateNoteVC", sender: self)
    }
    @IBAction func unwindSegueToTakeNoteVC(segue:UIStoryboardSegue){
        
    }
    //MARK: - Helper Method
    func authenticateBiometrics(completion: @escaping (_ result:Bool) -> Void){
        let myContext = LAContext()
        let myLocalizedReasonString = "Our app uses Touch ID / Face ID to secure your notes"
        var authError:NSError?
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { (sucess, evaluateError) in
                DispatchQueue.main.async {
                    if sucess{
                        completion(true)
                    }else{
                        guard let evaluateErrorString = evaluateError?.localizedDescription else {return}
                        self.showAlert(message: evaluateErrorString)
                        completion(false)
                    }
                }
            }
        }else{
            guard let authErrorString = authError?.localizedDescription else {return}
            self.showAlert(message: authErrorString)
            completion(false)
        }
    }
    //
    func showAlert(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let btn_OK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(btn_OK)
        self.present(alert, animated: true, completion: nil)
    }
}
extension TakeNoteVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteCell {
            cell.configureCell(with: notes[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedNote = notes[indexPath.row]
        if notes[indexPath.row].lockStatus == true{
            authenticateBiometrics { (success) in
                if success{
                    let managedObjectContext = AppDelegate.managedObjectContext
                    let note = self.notes[indexPath.row]
                    note.lockStatus = false
                    do{
                        try managedObjectContext?.save()
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }catch{
                        print("Can not unlock and update lock status")
                    }
                    
                }else{
                   print("Mo khoa khong thanh cong")
                }
            }
        }else{
            self.performSegue(withIdentifier: "toDetailNoteVC", sender: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteBtn = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if self.notes[indexPath.row].lockStatus == true{
                self.authenticateBiometrics { (success) in
                    if success{
                        let managedObjectContext = AppDelegate.managedObjectContext
                        let note = self.notes[indexPath.row]
                        managedObjectContext?.delete(note)
                        do{
                            try managedObjectContext?.save()
                            self.notes.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                            self.tableView.reloadData()
                        }catch{
                            print("Can not delete and save")
                        }
                    }
                }
            }else{
                let managedObjectContext = AppDelegate.managedObjectContext
                let note = self.notes[indexPath.row]
                managedObjectContext?.delete(note)
                do{
                    try managedObjectContext?.save()
                    self.notes.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                    self.tableView.reloadData()
                }catch{
                    print("Can not delete and save")
                }
            }
        }
        let editBtn = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            if self.notes[indexPath.row].lockStatus == true{
                self.authenticateBiometrics { (success) in
                    if success{
                        self.selectedNote = self.notes[indexPath.row]
                        self.performSegue(withIdentifier: "toUpdateNoteVC", sender: nil)
                    }
                }
            }else{
                self.selectedNote = self.notes[indexPath.row]
                self.performSegue(withIdentifier: "toUpdateNoteVC", sender: nil)
            }
        }
        editBtn.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        return [deleteBtn, editBtn]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateNoteVC"{
            let dest = segue.destination as! UpdateNoteVC
            dest.noteSelected = selectedNote
        }
        if segue.identifier == "toDetailNoteVC"{
            let dest = segue.destination as! DetailNote
            dest.selectedNote = selectedNote
        }
    }
}
