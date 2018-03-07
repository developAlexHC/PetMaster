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
import GoogleSignIn

class Login_ViewController: UIViewController {
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    //登入按鈕
    @IBAction func loginButton(_ sender: Any) {
        login()
        closeKeyboard()
    }
   
    

    @IBAction func signInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
/*
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            
            vc.emailLabel.text = user?.email
            vc.nameLabel.text = user?.displayName
            
            DispatchQueue.global().async {
                let imgData = try? Data(contentsOf: (user?.photoURL)!)
                
                DispatchQueue.main.async {
                    if let data = imgData{
                        let image = UIImage(data: data)
                        vc.profileImgView.image = image
                    }
                }
            }
            
        }
    }
 */
    
    //facebook登入
    @IBAction func signInWithFacebook(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"] , from: self) { (result, error) in
            
            if let error = error {
                    print("Failed to login:\(error.localizedDescription)")
                self.showMsg("Failed to login\(error.localizedDescription)")
            }else{
                self.MainView()
                print("tokenString: \(FBSDKAccessToken.current().tokenString)")
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login Error:\(error.localizedDescription)")
                    self.showMsg("Login Error")
                }
            })
        }
    }
    


    //按任意畫面收鍵盤
    @IBAction func closeKeyboardGesture(_ sender: Any) {
        closeKeyboard()
    }
    
    
    func login() {
        if emailLogin.text == "" || passwordLogin.text == ""{
            showMsg("請輸入email和密碼")
        }
        Auth.auth().signIn(withEmail: emailLogin.text!, password: passwordLogin.text!) { (user, error) in
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
                return
            }
            // 註冊成功並顯示已登入
            self.MainView()
        }
    }
    
    func logout() {
        if Auth.auth().currentUser == nil {
            showMsg("未登入")
        }
        do{
           try Auth.auth().signOut()
            showMsg("登出成功")
            
        }catch let signOutError as NSError {
            showMsg(signOutError.localizedDescription)
        }
        
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
    
    func MainView() {
         if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView"){
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signInSilently()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
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
