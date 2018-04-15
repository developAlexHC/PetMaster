//
//  PetHospotalTableViewCell.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/4/15.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetHospotalTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
