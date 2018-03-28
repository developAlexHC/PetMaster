//
//  ServiceTypeViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/22.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class BeautyTypeViewController: UIViewController,UITextViewDelegate {

    var cellTag: Int?
    var picker  = UIDatePicker()
    let toolBar = UIToolbar()
    @IBOutlet weak var navTitleImage: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
     @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet var titleView: [UIView]!
    @IBOutlet weak var buttonView: UIButton!
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitleWithRGB(cellTag: cellTag!, r: cellTag!, g: cellTag!, b: cellTag!)
        setView()
        memoTextView.delegate = self
      
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
    
    
    func setView(){
        for i in 0..<titleView.count{
            titleView[i].layer.borderWidth = 1
            titleView[i].layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        }
        buttonView.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        buttonView.layer.cornerRadius = 8
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
