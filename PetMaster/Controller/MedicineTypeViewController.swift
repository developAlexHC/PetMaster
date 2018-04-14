//
//  MedicineViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/25.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase

class MedicineTypeViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate {

    var celltag:Int?
    var picker  = UIDatePicker()
    let toolBar = UIToolbar()
    var petIDFromNoti = ""
    
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
    @IBOutlet weak var VaccineMemoTextView: UITextView!
    @IBOutlet weak var medicineMemoTextView: UITextView!
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
    
    @IBAction func doneButton(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let medicineDate = dateMedicine.text , let vaccineDate = dateVaccine.text , let medicineMemo = medicineMemoTextView.text, let vaccineMemo = VaccineMemoTextView.text else {return}
        let medicineParameter = ["Item" : itemValue ,
                                 "Date" : medicineDate,
                                 "Memo" : medicineMemo ] as [String : Any]
        
        let vaccineParameter = ["Item" : itemValue ,
                                "Date" : vaccineDate,
                                "Memo" : vaccineMemo ] as [String : Any]
        
        switch handleMedicineVaccine.selectedSegmentIndex {
        case 0:
            uploadPetMedicineDatabaseWithUID(uid: uid, parameters: medicineParameter)
        case 1:
            uploadPetVaccineDatabaseWithUID(uid: uid, parameters: vaccineParameter)
        default:
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineMemoTextView.delegate = self
        VaccineMemoTextView.delegate = self
        setView()
        reciveNotiPetProfile()
        reciveNoti()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemTVC = segue.destination as? ItemSelectTableViewController {
            itemTVC.tag = celltag
            itemTVC.segmentedIndex = handleMedicineVaccine.selectedSegmentIndex
        }
    }
    
    func reciveNotiPetProfile(){
        let noti = Notification.Name("GetPetprofile")
        NotificationCenter.default.addObserver(self, selector: #selector(getPetID(noti:)), name: noti, object: nil)
    }
    
    @objc func getPetID(noti:Notification){
        guard let petID = (noti.userInfo!["petID"] as Any) as? String else {return}
        petIDFromNoti = petID

    }
    
    
    func reciveNoti(){
        let notificationName = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(getUpdateNoti(noti:)), name: notificationName, object: nil)
    }
    
    @objc func getUpdateNoti(noti:Notification) {
        //接收編輯頁面回傳的資訊
        item = noti.userInfo!["PASS"] as! [Int : String]
        for value in item.values{
            itemValue.append(value)
        }
        
        updateItemLabel()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            medicineMemoTextView.resignFirstResponder()
            VaccineMemoTextView.resignFirstResponder()
            return false
        }
        return true
    }
   
    
}
