//
//  Edit_TableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/1.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase



class AddPet_TableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

  
    var genderSelect = [Gender.male, Gender.female]
    var genderPicker = UIPickerView()
    var birthDatePicker = UIDatePicker()
    var pet = [PetInfo]()
    var imagePiked = 0
    
    @IBOutlet weak var petName_TextField: UITextField!
    @IBOutlet weak var petGender_TextField: UITextField!
    @IBOutlet weak var petType_TextField: UITextField!
    @IBOutlet weak var petBreed_TextField: UITextField!
    @IBOutlet weak var petColor_TextField: UITextField!
    @IBOutlet weak var petBirthday_TextField: UITextField!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petBackgroundImage: UIImageView!
    
    @IBAction func selectPetBackgroundButton(_ sender: UIButton) {
        imagePiked = sender.tag
        //print("background")
        handleSelectPetProfileImage()
    }
    
    @IBAction func selectPetImageButton(_ sender: UIButton) {
        imagePiked = sender.tag
        //print(imagePiked)
        handleSelectPetProfileImage()
    }

    
    @IBAction func doneButton(_ sender: Any) {
        uploadPetProgileFromDoneButton()
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setPetImage() {
        petImageView.isUserInteractionEnabled = true
       // petImageView.image = #imageLiteral(resourceName: "dog")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        createPickerView()
        createDatePiclker()
        textPlachHolder()
        setPetImage()
    }

    
    //-----------------------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderSelect.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderSelect[row].rawValue
 
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        petGender_TextField.text = genderSelect[row].rawValue
        
    }
    //-----------------------------------------------------------

    
    

    
    func createPickerView(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        petGender_TextField.inputView = genderPicker
        petGender_TextField.inputAccessoryView = toolbar
        
    }
    
    func createDatePiclker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([spaceButton,done], animated: false)
        
        petBirthday_TextField.inputAccessoryView = toolbar
        petBirthday_TextField.inputView = birthDatePicker
        
        birthDatePicker.datePickerMode = .date
        birthDatePicker.locale = Locale(identifier: "zh_TW")
        
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateString = formatter.string(from: birthDatePicker.date)
        let dateFromTime = formatter.date(from: "2001/01/01")
        birthDatePicker.minimumDate = dateFromTime
        petBirthday_TextField.text = "\(dateString)"
        petGender_TextField.text = "\((petGender_TextField.text)!)"
        self.view.endEditing(true)
        
    }
    
    func textPlachHolder(){
        petType_TextField.placeholder = "狗,貓..."
        petBreed_TextField.placeholder = "法鬥,柯基,英國短毛貓..."
        petColor_TextField.placeholder = "灰色,黃色,長毛,短毛..."
        
    }


}
