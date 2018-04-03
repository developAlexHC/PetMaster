//
//  ItemSelectTableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/23.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class ItemSelectTableViewController: UITableViewController {
    
    var tag:Int?
    var segmentedIndex:Int?
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func checkButton(_ sender: Any) {
        let notificationName = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["PASS":itemSelect])
        navigationController?.popToRootViewController(animated: true)
        itemSelect.removeAll()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedIndex == 0 || segmentedIndex == 1{
            if let itemMedicine = itemType[tag!][segmentedIndex!] as? Array<String>{
                //print(itemMedicine.count)
                return itemMedicine.count
            }
        }
        return itemType[tag!].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) as? ItemSelectTableViewCell{
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
            }
            
            if segmentedIndex == 0 || segmentedIndex == 1{
                if let item = itemType[tag!][segmentedIndex!] as? Array<String>{
                    cell.itemLabel.text = item[indexPath.row] as? String
                }
            }else{
                let item = itemType[tag!]
                cell.itemLabel.text = item[indexPath.row] as? String
            }
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemSelect.count < 3{
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                itemSelect.removeValue(forKey: indexPath.row)
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                if segmentedIndex == 0 || segmentedIndex == 1{
                    if let item = itemType[tag!][segmentedIndex!] as? Array<String>{
                        itemSelect[indexPath.row] = item[indexPath.row] as? String
                    }
                }else{
                    let item = itemType[tag!]
                    itemSelect[indexPath.row] = item[indexPath.row] as? String
                }
            }
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            itemSelect.removeValue(forKey: indexPath.row)
        }
        
        print(itemSelect)
    }

}
