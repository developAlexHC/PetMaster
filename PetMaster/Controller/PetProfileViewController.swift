//
//  PetProfileViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetProfileViewController: UIViewController {
   
    
    var petProfile:PetInfo?

    @IBOutlet weak var petProgileImage: UIImageView!
    @IBAction func alertButton(_ sender: Any) {
        
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


