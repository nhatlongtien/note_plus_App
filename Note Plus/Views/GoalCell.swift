//
//  GoalCell.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/5/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var completeGoalView: UIView!
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        completeGoalView.isHidden = true
    }
    func configureCell(with goalDescription:String, goalType:goalType, goalProgress:Int){
        self.goalDescriptionLbl.text = goalDescription
        self.goalTypeLbl.text = goalType.rawValue
        self.goalProgressLbl.text = String(describing: goalProgress)
    }
   

}
