//
//  CreateGoalVC.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    //MARK: Model
    var goalType:goalType = .shortTerm
    //MARK: UI event
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //Defaut goalType
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeSelectedColor()
        //
        goalTextView.delegate = self
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        shortTermBtn.setSelectedColor()
        goalType = .shortTerm
        longTermBtn.setDeSelectedColor()
    }
    @IBAction func longtermBtnWasPressed(_ sender: Any) {
        longTermBtn.setSelectedColor()
        goalType = .longTerm
        shortTermBtn.setDeSelectedColor()
    }
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let finishGoalVC = storyboard.instantiateViewController(identifier: "finishGoalVC") as! FinishGoalVC
        finishGoalVC.goalDescription = goalTextView.text
        finishGoalVC.goalType = goalType
        self.presentDetail(finishGoalVC)
        
    }
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.dismissDetail()
    }
    //MARK: Helper Method
    @objc func handleTap(){
        view.endEditing(true)
    }
}
//MARK: UITextView Delegate
extension CreateGoalVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
    }
}

