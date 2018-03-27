//
//  ServiceTypeViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/22.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class BeautyTypeViewController: UIViewController {

    var cellTag: Int?
    @IBOutlet weak var navTitleImage: UIImageView!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitleWithRGB(cellTag: cellTag!, r: cellTag!, g: cellTag!, b: cellTag!)
        setViewControllerScreen()
      
    }

  
    
    func setViewControllerScreen() {
        let titleview = UIView()
        titleview.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        titleview.layer.borderWidth = 1
        titleview.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        titleview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleview)
        
        //constraint anchors
        //x,y,w,h
        titleview.leftAnchor.constraint(equalTo: view.leftAnchor ).isActive = true
        titleview.topAnchor.constraint(equalTo:view.topAnchor, constant: 64 ).isActive = true
        titleview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleview.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let titleLabel = UILabel()
        titleLabel.text = "服務項目"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleview.addSubview(titleLabel)
        
        //label x,y,w,h
        titleLabel.leftAnchor.constraint(equalTo: titleview.leftAnchor, constant: 12).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleview.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20)
        
        
        let titleButton = UIButton()
        titleButton.setTitle("新增", for: .normal)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleButton.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        titleButton.layer.cornerRadius = 8
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.addTarget(self, action: #selector(handleToItemSelect), for: .touchUpInside)
        titleview.addSubview(titleButton)
        
        //button x,y,w,h
        titleButton.rightAnchor.constraint(equalTo: titleview.rightAnchor, constant: -20).isActive = true
        titleButton.centerYAnchor.constraint(equalTo: titleview.centerYAnchor).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        titleButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        //––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
        
        let itemView = UIView()
        itemView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemView)
        
        //itemView x,y,w,h
        itemView.leftAnchor.constraint(equalTo: titleview.leftAnchor).isActive = true
        itemView.topAnchor.constraint(equalTo: titleview.bottomAnchor).isActive = true
        itemView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        itemView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
        
        let timetitleview = UIView()
        timetitleview.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        timetitleview.layer.borderWidth = 1
        timetitleview.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        timetitleview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timetitleview)

        //constraint anchors
        //x,y,w,h
        timetitleview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        timetitleview.topAnchor.constraint(equalTo: itemView.bottomAnchor).isActive = true
        timetitleview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        timetitleview.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let timetitleLabel = UILabel()
        timetitleLabel.text = "日期時間"
        timetitleLabel.font = UIFont.systemFont(ofSize: 18)
        timetitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timetitleview.addSubview(timetitleLabel)
        
        //label x,y,w,h
        timetitleLabel.leftAnchor.constraint(equalTo: timetitleview.leftAnchor, constant: 12).isActive = true
        timetitleLabel.centerYAnchor.constraint(equalTo: timetitleview.centerYAnchor).isActive = true
        timetitleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timetitleLabel.heightAnchor.constraint(equalToConstant: 25)
        
        //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
        
        let timeView = UIView()
        timeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeView)
        
        //itemView x,y,w,h
        timeView.leftAnchor.constraint(equalTo: timetitleview.leftAnchor).isActive = true
        timeView.topAnchor.constraint(equalTo: timetitleview.bottomAnchor).isActive = true
        timeView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        timeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

        let memotitleview = UIView()
        memotitleview.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        memotitleview.layer.borderWidth = 1
        memotitleview.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        memotitleview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(memotitleview)
        
        //constraint anchors
        //x,y,w,h
        memotitleview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        memotitleview.topAnchor.constraint(equalTo: timeView.bottomAnchor).isActive = true
        memotitleview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        memotitleview.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let memotitleLabel = UILabel()
        memotitleLabel.text = "便條"
        memotitleLabel.font = UIFont.systemFont(ofSize: 18)
        memotitleLabel.translatesAutoresizingMaskIntoConstraints = false
        memotitleview.addSubview(memotitleLabel)
        
        //label x,y,w,h
        memotitleLabel.leftAnchor.constraint(equalTo: memotitleview.leftAnchor, constant: 12).isActive = true
        memotitleLabel.centerYAnchor.constraint(equalTo: memotitleview.centerYAnchor).isActive = true
        memotitleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        memotitleLabel.heightAnchor.constraint(equalToConstant: 25)
        
        //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

        let memoView = UIView()
        memoView.backgroundColor = UIColor(red: 254/255, green: 253/255, blue: 192/255, alpha: 1)
        memoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(memoView)

        //memoView x,y,w,h
        memoView.leftAnchor.constraint(equalTo: memotitleview.leftAnchor).isActive = true
        memoView.topAnchor.constraint(equalTo: memotitleview.bottomAnchor).isActive = true
        memoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        memoView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        let memoTextView = UITextView()
        memoTextView.backgroundColor = UIColor.clear
        memoTextView.font = UIFont.systemFont(ofSize: 16)
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        memoView.addSubview(memoTextView)
        
        //memoTextView x,y,w,h
        memoTextView.leftAnchor.constraint(equalTo: memoView.leftAnchor).isActive = true
        memoTextView.topAnchor.constraint(equalTo: memoView.topAnchor).isActive = true
        memoTextView.widthAnchor.constraint(equalTo: memoView.widthAnchor).isActive = true
        memoTextView.heightAnchor.constraint(equalTo: memoView.heightAnchor).isActive = true

    }
    
    @objc func handleToItemSelect(){
            performSegue(withIdentifier: "itemSelectSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemSelectSegue"{
            if let itemTVC = segue.destination as? ItemSelectTableViewController {
                itemTVC.tag = cellTag
                
            }
        }
    }
    

}
