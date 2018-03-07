//
//  Register_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/2/26.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Register_ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTestField: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        register()
        closeKeyboard()
    }
    @IBAction func closeKeyboardGesture(_ sender: Any) {
        closeKeyboard()
    }
    
    func closeKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func register() {
        if emailTextField.text == "" || passwordTestField.text == ""{
            showMsg("請輸入email和密碼")
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTestField.text!) { (user, error) in
            
             // 註冊失敗
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
                return
            }
            
            // 註冊成功並顯示已登入
            self.showMsg("已登入")
        }
    }
    
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
