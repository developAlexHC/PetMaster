//
//  ServiceTypeControllerExtexsion.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

extension BeautyTypeViewController {
    
    func setNavTitleWithRGB(cellTag:Int, r:Int, g:Int, b:Int){
        navTitleImage.image = UIImage(named: "\(petService[cellTag].titleENG)-nav")
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(petService[cellTag].Red)/255, green: CGFloat(petService[cellTag].Green)/255, blue:CGFloat(petService[cellTag].Blue)/255, alpha: 1)
    }
}
