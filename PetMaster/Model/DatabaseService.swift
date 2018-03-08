//
//  DatabaseService.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/8.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    static let share = DatabaseService()
    private init() {}
        
    let petRenfence: DatabaseReference = Database.database().reference().child("pets")
    
}
