//
//  Constants.swift
//  
//
//  Created by Alex Hsieh on 2018/3/1.
//

import Foundation

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

var itemType = [["洗澡", "美容", "造型", "Spa", "藥浴", "其他項目"],
               [["止痛藥","驅蟲藥","皮膚滴劑"],
                ["二合一","六合一","七合一","八合一","幼犬疫苗","狂犬病疫苗","萊姆病疫苗"] ],
               ["外傷","發燒","發抖","便秘","腹瀉","嘔吐","流鼻涕","流口水","食慾不振","呼吸困難","飲水障礙","抓頭/抓耳","鼻子乾燥/發熱","皮膚搔癢"]
]

