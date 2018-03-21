//
//  DatabaseSnapshot.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/9.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation
import Firebase

struct PetsSnapshot {
    
    let pets: [PetInfo]
    
    init?(snapshot:DataSnapshot) {
        var pets = [PetInfo]()
        guard let snapDict = snapshot.value as? [String: [String: Any]] else { return nil}
        for snap in snapDict {
            guard let pet = PetInfo(petID: snap.key , dict: snap.value) else { continue }
            pets.append(pet)
        }
        self.pets = pets
    }
}
//
//struct UserSnapshot {
// 
//    let users: User
//    
//    init?(snapshot:DataSnapshot){
//        var users = [User]()
//        guard let UserSnapShot = snapshot.value as? [String: Any] else {return nil}
//        
//        self.users = users
//    }
//}

