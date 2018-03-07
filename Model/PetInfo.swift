//
//  PetInfo.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/1.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation

class PetInfo {
        var petName:String
        var petGender:Gender
        var petType:String
        var petBreed:String
        var perColor:String
        var petBirthday:Data
        var petIndex:String?
        
        init(petName:String, petGender:Gender, petType:String, petBreed:String, petColor:String, petBirthday:Data, petIndex:String?) {
            self.petName = petName
            self.petGender = petGender
            self.petType = petType
            self.petBreed = petBreed
            self.perColor = petColor
            self.petBirthday = petBirthday
            self.petIndex = petIndex
        }
}

struct petHealthy {
    var petLigation:Bool
}

enum Gender:String {
    case male = "男生"
    case female = "女生"
}
