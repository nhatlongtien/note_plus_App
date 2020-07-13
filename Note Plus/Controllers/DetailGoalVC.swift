//
//  DetailGoalVC.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DetailGoalVC: UIViewController {
    var goalSelected:Goal?
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        goalDescriptionLbl.text = goalSelected?.goalDescription
        goalTypeLbl.text = goalSelected?.goalType
    }

    @IBAction func closeBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
