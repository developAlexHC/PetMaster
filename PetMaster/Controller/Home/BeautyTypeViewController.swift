//
//  ServiceTypeViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/22.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase

class BeautyTypeViewController: UIViewController,UITextViewDelegate {

    var cellTag: Int?
    var picker  = UIDatePicker()
    let toolBar = UIToolbar()
    var petProfile : PetInfo?
    var petIDFromNoti = ""
    
    @IBOutlet var itemLabels: [UILabel]!
    @IBOutlet weak var navTitleImage: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet var titleView: [UIView]!
    @IBOutlet weak var buttonView: UIButton!
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        itemValue.removeAll()
        
    }

    @IBAction func doneButton(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let date = dateTextField.text , let memo = memoTextView.text else {return}
        
        let parameter = ["Item" : itemValue ,
                         "Date" : date,
                         "Memo" : memo ] as [String : Any]
        uploadPetBeautyDatabaseWithUID(uid: uid, parameters: parameter)
        //recordBeauty.append(beauty(beautyItem: itemValue, date: dateTextField.text!, memo: memoTextView.text))
        itemValue.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
        setView()
        reciveNoti()
        reciveNotiPetProfile()
        
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
        item =  noti.userInfo!["PASS"] as! [Int : String]
        for value in item.values{
            itemValue.append(value)
        }
        updateItemLabel()
    }
    
    

    
    @IBAction func selectItemButton(_ sender: Any) {
        itemValue.removeAll()
    
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            memoTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let itemTVC = segue.destination as? ItemSelectTableViewController {
                itemTVC.tag = cellTag
            }
    }

}
