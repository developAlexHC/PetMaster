//
//  DatabaseService.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/8.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    static let share = FirebaseService()
    private init() {}
    
    
    let petRenfence: DatabaseReference = Database.database().reference().child("Users").child("pets")
    let userRenfence : DatabaseReference = Database.database().reference().child("Users")
    
    let petImageRenference: StorageReference = Storage.storage().reference()
}
