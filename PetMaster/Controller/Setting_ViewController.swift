//
//  Setting_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/9.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit



class Setting_ViewController: UIViewController {



    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    
    @IBAction func Signout_button(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            presentViewController(viewControllerID: propertyKey.loginview)
        }catch let signOutError as NSError {
            showMsg(signOutError.localizedDescription)
        }
        
    }
    
 
    
    func presentViewController(viewControllerID:String) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: viewControllerID) else {return}
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
