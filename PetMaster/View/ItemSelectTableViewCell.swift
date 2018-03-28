//
//  ItemSelectTableViewCell.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/24.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class ItemSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
