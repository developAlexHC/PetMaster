//
//  Beauty.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation

var recordBeauty = [beauty]()

struct beauty {
    var beautyItem:[String]
    var date: String
    var memo: String
}



enum BeautyType: String {
    case bathe = "洗澡"
    case beauty = "美容"
    case modeling = "造型"
    case spa = "Spa"
    case MedicatedBath = "藥浴"
    case other = "其他項目"
}
