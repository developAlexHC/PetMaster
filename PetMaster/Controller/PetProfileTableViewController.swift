//
//  PetProfileTableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetProfileTableViewController: UITableViewController {

    var petServiceType = petService
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petService.count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PetProfileTableViewCell {
            let petServiceType = self.petServiceType[indexPath.row]
            cell.typeTitle.text = "➕添加\(petServiceType.title)紀錄"
            cell.typeImage.image = UIImage(named: "\(petServiceType.titleENG)")
            cell.buttonBackgroundColor.backgroundColor = UIColor(red: CGFloat(petServiceType.Red)/255, green: CGFloat(petServiceType.Green)/255, blue: CGFloat(petServiceType.Blue)/255, alpha: 0.4)
            
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: propertyKey.beautySegue, sender: nil)
        case 1:
            performSegue(withIdentifier: propertyKey.medicineSegue, sender: nil)
        case 2:
            performSegue(withIdentifier: propertyKey.hospitalSegue, sender: nil)
        case 3:
            performSegue(withIdentifier: propertyKey.otherSegue, sender: nil)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if segue.identifier == propertyKey.beautySegue {
            if let navigation = segue.destination as? UINavigationController {
                if let beautyTypeVC = navigation.topViewController as? BeautyTypeViewController {
                    guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
                    beautyTypeVC.cellTag = indexPath
                }
            }
        }else if segue.identifier == propertyKey.medicineSegue {
            if let navigation = segue.destination as? UINavigationController {
                if let medicineTypeVC = navigation.topViewController as? MedicineTypeViewController {
                    guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
                    medicineTypeVC.celltag = indexPath
                }
            }

        }else if segue.identifier == propertyKey.hospitalSegue{
            if let navigation = segue.destination as? UINavigationController{
                if let hospitalTypeVC = navigation.topViewController as? HospitalTypeViewController {
                    guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
                    hospitalTypeVC.cellTag = indexPath
                }
            }
        }else{
            if let navigation = segue.destination as? UINavigationController {
                if let otherTypeVC = navigation.topViewController as? OtherTypeViewController {
                    guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
                    otherTypeVC.cellTag = indexPath
                }
            }
        }
   }

}
