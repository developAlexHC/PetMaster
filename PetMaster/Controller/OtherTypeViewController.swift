//
//  OtherTypeViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/25.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class OtherTypeViewController: UIViewController {

    var cellTag:Int?
    
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet var titleView: [UIView]!
    @IBOutlet weak var navTitleImage: UIImageView!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavTitleWithRGB(cellTag: cellTag!, r: cellTag!, g: cellTag!, b: cellTag!)
    }

    func setNavTitleWithRGB(cellTag:Int, r:Int, g:Int, b:Int){
        navTitleImage.image = UIImage(named: "\(petService[cellTag].titleENG)-nav")
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(petService[cellTag].Red)/255, green: CGFloat(petService[cellTag].Green)/255, blue:CGFloat(petService[cellTag].Blue)/255, alpha: 1)
    }
    
    func setView(){
        for i in 0..<titleView.count{
            titleView[i].layer.borderWidth = 1
            titleView[i].layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        }
            buttonView.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
            buttonView.layer.cornerRadius = 8
            buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }

}
