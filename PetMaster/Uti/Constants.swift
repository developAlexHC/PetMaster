//
//  Constants.swift
//  
//
//  Created by Alex Hsieh on 2018/3/1.
//

import Foundation
import UIKit

var CURRRNT_USER : User?

//var Pets = [PetInfo(petName: "豆奶", petGender:"\(Gender.male)", petType: "狗",
//                    petBreed: "法鬥", petColor: "沒毛",petBorn: "2016年4月12日",petIndex: nil,petImage : "Dowmilk"),
//            PetInfo(petName: "打打", petGender: "\(Gender.female)", petType: "狗", petBreed: "柯基", petColor: "長毛",
//                    petBorn:"2016年4月12日",petIndex: nil, petImage: "Dada"),
//            PetInfo(petName: "Soda", petGender: "\(Gender.male)", petType: "狗", petBreed: "柯基", petColor: "一點毛",
//                    petBorn: "2016年4月12日",petIndex: nil, petImage: nil)
//]

var petService = [PetServiceClass.init(title: "美容", titleEng: "beauty", Red: 252, Green: 72, Blue: 30),
                  PetServiceClass.init(title: "用藥", titleEng: "medicine", Red: 24, Green: 154, Blue: 75),
                  PetServiceClass.init(title: "醫療", titleEng: "hospital", Red: 32, Green: 173, Blue: 229),
                  PetServiceClass.init(title: "其他活動", titleEng: "other", Red: 141, Green: 120, Blue: 87) ]

var beautyType = ["洗澡", "美容", "造型", "Spa", "藥浴", "其他項目"]




extension UITextField {
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0) // 底線寬度
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height) // 設定外框位置及寬高
        border.borderWidth = width // 設定外框的粗細
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true // 將多出來的外誆遮掉
    }
    
}
