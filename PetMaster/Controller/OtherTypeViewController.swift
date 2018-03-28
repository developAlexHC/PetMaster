//
//  OtherTypeViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/25.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class OtherTypeViewController: UIViewController {

    var cellTag:Int?
    var picker  = UIDatePicker()
    let toolBar = UIToolbar()
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet var titleView: [UIView]!
    @IBOutlet weak var navTitleImage: UIImageView!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitleWithRGB(cellTag: cellTag!, r: cellTag!, g: cellTag!, b: cellTag!)
        setView()

    }

    func setNavTitleWithRGB(cellTag:Int, r:Int, g:Int, b:Int){
        navTitleImage.image = UIImage(named: "\(petService[cellTag].titleENG)-nav")
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(petService[cellTag].Red)/255, green: CGFloat(petService[cellTag].Green)/255, blue:CGFloat(petService[cellTag].Blue)/255, alpha: 1)
    }
    
    func setView(){
        for i in 0..<titleView.count{
            titleView[i].layer.borderWidth = 1
            titleView[i].layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        }
        setDateTextField()
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
        formatter.dateFormat = " yyyy/M/dd"
        let dateString = formatter.string(from: picker.date)
        dateTextField.text = dateString
        self.view.endEditing(true)
    }
    @objc func cancelClick(){
        self.view.endEditing(true)
    }
    

}
