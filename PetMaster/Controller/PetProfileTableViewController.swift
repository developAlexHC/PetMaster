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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController {
            if let serviceTypeTVC = navigation.topViewController as? ServiceTypeTableViewController {
                guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
                serviceTypeTVC.cellTag = indexPath
            }
        }
        
    }
    

}
