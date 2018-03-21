//
//  PetProfileTableViewCell.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var buttonBackgroundColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
