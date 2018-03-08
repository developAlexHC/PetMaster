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
        var petName:String
        var petGender:String
        var petType:String
        var petBreed:String
        var perColor:String
        var petBorn:String
        var petIndex:String?
        var petImage:String?
    
    
        init(petName:String, petGender:String, petType:String, petBreed:String, petColor:String, petBorn:String, petIndex:String?, petImage:String? ) {
    
            self.petName = petName
            self.petGender = petGender
            self.petType = petType
            self.petBreed = petBreed
            self.perColor = petColor
            self.petBorn = petBorn
            self.petIndex = petIndex
            self.petImage = petImage
        }
    
    
        init(snapshot:DataSnapshot) {
            let snapshotValue : [String:AnyObject] = snapshot.value as! [String:AnyObject]
            self.petName = snapshotValue["petName"] as! String
            self.petGender = snapshotValue["petGender"] as! String
            self.petType = snapshotValue["petType"] as! String
            self.petBreed = snapshotValue["petBreed"] as! String
            self.perColor = snapshotValue["petColor"] as! String
            self.petBorn = snapshotValue["petBorn"] as! String
    }
    
    
}

struct petHealthy {
    var petLigation:Bool
}

enum Gender:String {
    case male = "男生"
    case female = "女生"
}
