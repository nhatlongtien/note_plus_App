//
//  FinishGoalVC.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    //MARK: Models
    var goalDescription: String!
    var goalType:goalType!
    //MARK: UI element
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextfield: UITextField!
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        //
        pointsTextfield.delegate = self
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    //MARK: UI Events
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        let goalPoint = Int32(pointsTextfield.text!)
        Goal.instance.insertNewGoal(goalDescription: goalDescription, goalType: goalType.rawValue, goalCompletionValue: goalPoint!) { (sucess) in
            if sucess{
                self.performSegue(withIdentifier: "unwindToGoalVC", sender: nil)
            }
        }
    }
    //MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pointsTextfield.resignFirstResponder()
    }
    //MARK: Helper Method
    @objc func handleTap(){
        view.endEditing(true)
    }
}
