//
//  PetTypeService.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation

enum PetService: String{
    case beauty = "美容"
    case medicine = "用藥"
    case hospital = "醫療"
    case other = "其他活動"
}

class PetServiceClass {
    var title: String
    var titleENG: String
    var Red: Int
    var Green: Int
    var Blue: Int
    
    init(title:String, titleEng:String, Red:Int, Green:Int, Blue:Int) {
        self.title = title
        self.titleENG = titleEng
        self.Red = Red
        self.Green = Green
        self.Blue = Blue
    }
    
}
