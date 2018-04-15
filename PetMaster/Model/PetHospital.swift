//
//  PetHospital.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/4/15.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation

   var hospitalArray = [PetHospital]()

struct PetHospital {
    var hospitalCity: String
    var hospitalName: String
    var hospitalAddress: String
    var hospitalNumber: String
    
    init?(json:[String: Any]){
        guard let hospitalCity = json["縣市"] as? String,
                let hospitalName = json["機構名稱"] as? String,
                let hospitalAddress = json["機構地址"] as? String,
                let hospitalNumber = json["機構電話"] as? String else {return nil}
        
        self.hospitalCity = hospitalCity
        self.hospitalName = hospitalName
        self.hospitalAddress = hospitalAddress
        self.hospitalNumber = hospitalNumber
    }
}
