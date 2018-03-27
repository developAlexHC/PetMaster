//
//  Login_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/2/26.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class Login_ViewController: UIViewController {
    
    @IBOutlet weak var handleSignInRegister_Segment: UISegmentedControl!
    
    @IBOutlet weak var HandleSignIn: UIStackView!
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    @IBOutlet weak var HandleRegister: UIStackView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    
    var homeController: Home_ViewController?

    
    //登入按鈕
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
   
    
    @IBAction func registerButton(_ sender: Any) {
        register()
    }
    
    //facebook登入
    @IBAction func signInWithFacebook(_ sender: Any) {
        faceBookSignIn()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //handleSignInRegister()
        
    }
    
    func login() {
        guard let email = emailLogin.text, let password = passwordLogin.text else {return}
        if email.isEmpty || password.isEmpty {
            showMsg("請輸入email或密碼")
        }

        
        Auth.auth().signIn(withEmail: email, password: password ) { (user, error) in
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
                return
            }
            // 註冊成功並顯示已登入
            self.homeController?.fetchUserSetTitle()
            self.dismiss(animated: true, completion: nil)

        }
    }
    
    func register() {
        guard let name = userName.text, let email = registerEmail.text, let password = registerPassword.text else {return}
        if name == "" || email == "" || password == "" {
            showMsg("欄位不得空白")
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                return
            }
            
            //successful creat new user
            guard let uid = user?.uid else {return}
            let userParameter = ["name": name, "email": email ]
            FirebaseService.share.userRenfence.child(uid).setValue(userParameter)
            self.dismiss(animated: true, completion: nil)
            self.homeController?.fetchUserSetTitle()
            
    
        }
    }
    
    //按任意畫面收鍵盤
    @IBAction func closeKeyboardGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func segmentButton(_ sender: Any) {
        switch handleSignInRegister_Segment.selectedSegmentIndex {
        case 0:
            HandleSignIn.isHidden = false
            HandleRegister.isHidden = true
        case 1:
            HandleSignIn.isHidden = true
            HandleRegister.isHidden = false
        default:
            return
        }
    }
    
    func handleSignInRegister() {
        handleSignInRegister_Segment.setTitle("Sign In", forSegmentAt: 0)
        handleSignInRegister_Segment.setTitle("Register", forSegmentAt: 1)
    }


    
    func faceBookSignIn(){
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"] , from: self) { (result, error) in
            
            if let error = error {
                print("Failed to login:\(error.localizedDescription)")
                self.showMsg("Failed to login\(error.localizedDescription)")
            }else{
                self.presentViewController(viewControllerID: "MainView")
                print("tokenString: \(FBSDKAccessToken.current().tokenString)")
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                guard let error = error else { return }
                print("Login Error:\(error.localizedDescription)")
                self.showMsg("Login Error")
            })
        }

    }
    
    func presentViewController(viewControllerID:String) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: viewControllerID){
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
  
}


