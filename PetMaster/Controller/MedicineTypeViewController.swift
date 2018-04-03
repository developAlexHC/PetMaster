//
//  MedicineViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/25.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class MedicineTypeViewController: UIViewController,UITextFieldDelegate {

    var celltag:Int?
    var picker  = UIDatePicker()
    let toolBar = UIToolbar()
 
    @IBOutlet weak var dateVaccine: UITextField!
    @IBOutlet weak var dateMedicine: UITextField!
    @IBOutlet weak var navTitleImage: UIImageView!
    @IBOutlet weak var handleMedicineVaccine: UISegmentedControl!
    @IBOutlet var titleView: [UIView]!
    @IBOutlet var buttonView: [UIButton]!
    @IBOutlet weak var medicineStack: UIStackView!
    @IBOutlet weak var vaccineStack: UIStackView!
    @IBOutlet var medicineItemLabels: [UILabel]!
    @IBOutlet var vaccineItemLabels: [UILabel]!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleMedicineVaccine(_ sender: UISegmentedControl) {
        switch handleMedicineVaccine.selectedSegmentIndex {
        case 0:
            medicineStack.isHidden = false
            vaccineStack.isHidden = true
        case 1:
            medicineStack.isHidden = true
            vaccineStack.isHidden = false
        default:
            return
        }
    }
    
    
    @IBAction func medicineButton(_ sender: Any) {
        itemValue.removeAll()
    }
    
    @IBAction func vaccineButton(_ sender: Any) {
        itemValue.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavTitleWithRGB(cellTag: celltag!, r: celltag!, g: celltag!, b: celltag!)
        let notificationName = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(getUpdateNoti(noti:)), name: notificationName, object: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemTVC = segue.destination as? ItemSelectTableViewController {
            itemTVC.tag = celltag
            itemTVC.segmentedIndex = handleMedicineVaccine.selectedSegmentIndex
            
        }
    }
    
    @objc func getUpdateNoti(noti:Notification) {
        //接收編輯頁面回傳的資訊
        item = noti.userInfo!["PASS"] as! [Int : String]
        
        for value in item.values{
            itemValue.append(value)
        }
        print(itemValue)
        updateItemLabel()
    }
    
    func updateItemLabel(){
        if handleMedicineVaccine.selectedSegmentIndex == 0{
            switch itemValue.count {
            case 1:
                medicineItemLabels[0].text = itemValue[0]
                medicineItemLabels[0].isHidden = false
                medicineItemLabels[1].isHidden = true
                medicineItemLabels[2].isHidden = true
            case 2:
                medicineItemLabels[0].text = itemValue[0]
                medicineItemLabels[1].text = itemValue[1]
                medicineItemLabels[0].isHidden = false
                medicineItemLabels[1].isHidden = false
                medicineItemLabels[2].isHidden = true
            case 3:
                medicineItemLabels[0].text = itemValue[0]
                medicineItemLabels[1].text = itemValue[1]
                medicineItemLabels[2].text = itemValue[2]
                medicineItemLabels[0].isHidden = false
                medicineItemLabels[1].isHidden = false
                medicineItemLabels[2].isHidden = false
            default:
                medicineItemLabels[0].isHidden = true
                medicineItemLabels[1].isHidden = true
                medicineItemLabels[2].isHidden = true
            }
        }else{
            switch itemValue.count {
            case 1:
                vaccineItemLabels[0].text = itemValue[0]
                vaccineItemLabels[0].isHidden = false
                vaccineItemLabels[1].isHidden = true
                vaccineItemLabels[2].isHidden = true
            case 2:
                vaccineItemLabels[0].text = itemValue[0]
                vaccineItemLabels[1].text = itemValue[1]
                vaccineItemLabels[0].isHidden = false
                vaccineItemLabels[1].isHidden = false
                vaccineItemLabels[2].isHidden = true
            case 3:
                vaccineItemLabels[0].text = itemValue[0]
                vaccineItemLabels[1].text = itemValue[1]
                vaccineItemLabels[2].text = itemValue[2]
                vaccineItemLabels[0].isHidden = false
                vaccineItemLabels[1].isHidden = false
                vaccineItemLabels[2].isHidden = false
            default:
                vaccineItemLabels[0].isHidden = true
                vaccineItemLabels[1].isHidden = true
                vaccineItemLabels[2].isHidden = true
            }
        }
       
    }
    
    func setDateTextField(){
        //Vaccine TextField
        dateVaccine.font = UIFont.systemFont(ofSize: 25)
       dateVaccine.underlined()
        dateVaccine.inputView = picker
        dateVaccine.inputAccessoryView = toolBar
   
        //Medicine TextField
        dateMedicine.font = UIFont.systemFont(ofSize: 25)
        dateMedicine.underlined()
        dateMedicine.inputView = picker
        dateMedicine.inputAccessoryView = toolBar
        
        
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "zh_TW")
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
        if handleMedicineVaccine.selectedSegmentIndex == 0 {
            dateMedicine.text = dateString
        }else{
            dateVaccine.text = dateString
        }
        self.view.endEditing(true)
    }
    @objc func cancelClick(){
        self.view.endEditing(true)
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
        for i in 0..<buttonView.count{
            buttonView[i].backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
            buttonView[i].layer.cornerRadius = 8
            buttonView[i].titleLabel?.font = UIFont.systemFont(ofSize: 18)
        }
        setDateTextField()
    }
    
}
