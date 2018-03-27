//
//  PetInfo.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/1.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation
import Firebase


struct PetInfo {
        var petID:String
        var petName:String
        var petGender:String
        var petType:String
        var petBreed:String
        var perColor:String
        var petBorn:String
        var petIndex:String?
        var petImage:String?
        var petBackgroundImage:String?
    
    
    init?(petID:String, dict:[String:Any]) {
        self.petID = petID
        guard let petName = dict["petName"] as? String,
            let petGender = dict["petGender"] as? String,
            let petType = dict["petType"] as? String,
            let petBreed = dict["petBreed"] as? String,
            let perColor = dict["petColor"] as? String,
            let petBorn = dict["petBorn"] as? String,
            let petImage = dict["petImage"] as? String,
            let petBackgroundImage = dict["petBackground"] as? String else { return nil}
        
        self.petName = petName
        self.petGender = petGender
        self.petType = petType
        self.petBreed = petBreed
        self.perColor = perColor
        self.petBorn = petBorn
        self.petImage = petImage
        self.petBackgroundImage = petBackgroundImage
    }
}


enum Gender:String {
    case male = "男生"
    case female = "女生"
}
