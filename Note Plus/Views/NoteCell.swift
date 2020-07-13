//
//  NoteCell.swift
//  Note Plus
//
//  Created by NGUYENLONGTIEN on 7/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var imageLock: UIImageView!
    @IBOutlet weak var noteContentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(with note:Note){
        self.noteContentLbl.text = note.content
        if note.lockStatus == true{
            self.imageLock.image = UIImage(named: "lockImage")
        }else{
            self.imageLock.image = UIImage(named: "unlock")
        }
    }

}
