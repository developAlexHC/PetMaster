//
//  MainView_ViewController.swift
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

class MainView_ViewController: UIViewController {

    
    @IBAction func logoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            LoginView()
        }catch let signOutError as NSError {
            showMsg(signOutError.localizedDescription)
        }
    }
    
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func LoginView() {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView"){
            self.present(viewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
