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
        arrayAsString()
    }
    
    func arrayAsString(){
        //print(itemType[tag!])
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

            //cell.itemLabel.text = "balabala"
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
        
            
            
            //let test = beautyType[indexPath.row]

    
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }

}
