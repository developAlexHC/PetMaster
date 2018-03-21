//
//  User.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/10.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
    
    var uid: String?
    var userName: String?
    var userEmail: String?
    //var userImageName:String?
    
    func clearAll(){
        uid?.removeAll()
        userName?.removeAll()
        userEmail?.removeAll()
        
    }
}
