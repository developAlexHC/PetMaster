//
//  PetProfileViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase

class PetProfileViewController: UIViewController {
   
    
    var petProfile:PetInfo?
    
    
    @IBOutlet weak var petProgileImage: UIImageView!

    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "提示", message: "您確定要刪除寵物嗎?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "確定", style: .default) { (alert) in
            self.deletePet()
            self.navigationController?.popViewController(animated: true)
        }
        let cancelButton  = UIAlertAction(title: "取消", style: .destructive) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    func deletePet(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let petProfile = petProfile else {return}
        FirebaseService.share.userRenfence.child(uid).child("pets").child(petProfile.petID).removeValue()
        //print(ref.key)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPetProfileImage()
    }
    
    func setPetProfileImage() {
        if let petImageUrl = petProfile?.petImage {
            petProgileImage.loadImageUsingCacheWithUrlString(urlString: petImageUrl)
        }
    }

}


