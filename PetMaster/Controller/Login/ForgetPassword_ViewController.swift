//
//  ForgetPassword_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/2/26.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgetPassword_ViewController: UIViewController {
   

    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func resetButton(_ sender: Any) {
        reset()
    }
    @IBAction func closeKeyboardGesture(_ sender: Any) {
        closeKeyboard()
    }
    func reset(){
        if emailTextField.text == ""{
            showMsg("請輸入Email")
        }
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
            }
            
            self.showMsg("重設成功，請檢查信箱信件")
        }
        closeKeyboard()
    }
    
    func closeKeyboard() {
        view.endEditing(true)
    }
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
