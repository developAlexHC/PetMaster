//
//  MedicineViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/25.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class MedicineTypeViewController: UIViewController {

    var celltag:Int?
    
    @IBOutlet weak var navTitleImage: UIImageView!
    @IBOutlet weak var handleMedicineVaccine: UISegmentedControl!
    @IBOutlet var titleView: [UIView]!
    @IBOutlet var buttonView: [UIButton]!
    @IBOutlet weak var medicineStack: UIStackView!
    @IBOutlet weak var vaccineStack: UIStackView!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func handleMedicineVaccine(_ sender: UISegmentedControl) {
        switch handleMedicineVaccine.selectedSegmentIndex {
        case 0:
            medicineStack.isHidden = false
            vaccineStack.isHidden = true
        case 1:
            medicineStack.isHidden = true
            vaccineStack.isHidden = false
        default:
            return
        }
    }
    @IBAction func medicineButton(_ sender: Any) {
        //performSegue(withIdentifier: "MedicineItemSegue", sender: self)
    }
    
    @IBAction func vaccineButton(_ sender: Any) {
        //performSegue(withIdentifier: "VaccineItemSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavTitleWithRGB(cellTag: celltag!, r: celltag!, g: celltag!, b: celltag!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemTVC = segue.destination as? ItemSelectTableViewController {
            itemTVC.tag = celltag
            itemTVC.segmentedIndex = handleMedicineVaccine.selectedSegmentIndex
            
        }
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
        for i in 0..<buttonView.count{
            buttonView[i].backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
            buttonView[i].layer.cornerRadius = 8
            buttonView[i].titleLabel?.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
}
