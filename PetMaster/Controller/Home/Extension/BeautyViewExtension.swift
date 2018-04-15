//
//  ServiceTypeControllerExtexsion.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

extension BeautyTypeViewController {
    
    
    func uploadPetBeautyDatabaseWithUID(uid:String, parameters:[String : Any]){
        FirebaseService.share.userRenfence.child(uid).child("pets").child(petIDFromNoti).child("Beauty").child("\(Date())").setValue(parameters) { (error, ref) in
            if error != nil {
                print("error")
                return
            }
        }
    }
    
    func setNavTitleWithRGB(cellTag:Int, r:Int, g:Int, b:Int){
        navTitleImage.image = UIImage(named: "\(petService[cellTag].titleENG)-nav")
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(petService[cellTag].Red)/255, green: CGFloat(petService[cellTag].Green)/255, blue:CGFloat(petService[cellTag].Blue)/255, alpha: 1)
    }
    
    func setView(){
        setNavTitleWithRGB(cellTag: cellTag!, r: cellTag!, g: cellTag!, b: cellTag!)

        for i in 0..<titleView.count{
            titleView[i].layer.borderWidth = 1
            titleView[i].layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        }
        buttonView.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        buttonView.layer.cornerRadius = 8
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        setDateTextField()
        
        itemLabels[0].backgroundColor = UIColor(red: 35/255, green: 194/255, blue: 176/255, alpha: 1)
        itemLabels[1].backgroundColor = UIColor(red: 255/255, green: 173/255, blue: 193/255, alpha: 1)
        itemLabels[2].backgroundColor = UIColor(red: 196/255, green: 141/255, blue: 193/255, alpha: 1)
    }
    
    func updateItemLabel(){
        switch itemValue.count {
        case 1:
            itemLabels[0].text = itemValue[0]
            itemLabels[0].isHidden = false
            itemLabels[1].isHidden = true
            itemLabels[2].isHidden = true
        case 2:
            itemLabels[0].text = itemValue[0]
            itemLabels[1].text = itemValue[1]
            itemLabels[0].isHidden = false
            itemLabels[1].isHidden = false
            itemLabels[2].isHidden = true
        case 3:
            itemLabels[0].text = itemValue[0]
            itemLabels[1].text = itemValue[1]
            itemLabels[2].text = itemValue[2]
            itemLabels[0].isHidden = false
            itemLabels[1].isHidden = false
            itemLabels[2].isHidden = false
        default:
            itemLabels[0].isHidden = true
            itemLabels[1].isHidden = true
            itemLabels[2].isHidden = true
        }
    }
    
    func setDateTextField(){
        dateTextField.font = UIFont.systemFont(ofSize: 25)
        dateTextField.underlined()
        dateTextField.inputView = picker
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "zh_TW")
        
        dateTextField.inputAccessoryView = toolBar
        toolBar.sizeToFit()
        toolBar.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        
        toolBar.isUserInteractionEnabled = true
        toolBar.isTranslucent = true
    }
    
    @objc func doneClick(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/dd"
        let dateString = formatter.string(from: picker.date)
        dateTextField.text = dateString
        self.view.endEditing(true)
    }
    
    @objc func cancelClick(){
        self.view.endEditing(true)
    }

}
