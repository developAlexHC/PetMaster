//
//  PetHospitalTableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/4/15.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetHospitalTableViewController: UITableViewController, UISearchResultsUpdating {


    var hospitalArray = [PetHospital]()
    var searchResult = [PetHospital]()
    let petHospitalUrlStr = "https://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=078&$top=1000&$skip=0"
    
    var searchController: UISearchController!
    var resultsTableViewController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadHospital(urlstr: petHospitalUrlStr)
        setSearchBar()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background-1"))
        tableView.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
    }

    

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return searchResult.count
        }else{
            return hospitalArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: propertyKey.petHospitalCell, for: indexPath) as? PetHospotalTableViewCell {
            let result = self.searchController.isActive ? searchResult[indexPath.row] : hospitalArray[indexPath.row]
                cell.nameLabel.text = result.hospitalName
                cell.addressLabel.text = result.hospitalAddress
                cell.numberLabel.text = result.hospitalNumber
                return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hospitalForCell" {
            if let hospitalLocationVC = segue.destination as? HospitalLocationViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    hospitalLocationVC.hospitalAddress = searchController.isActive ? searchResult[indexPath.row] : hospitalArray[indexPath.row]
                }
            }
        }
       
    }
    
    func downloadHospital(urlstr:String) {
        guard let url = URL(string: urlstr) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error")
            }
            guard let data = data else {return}
            do{
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                    DispatchQueue.main.async {
                        for hospitalResult in result {
                            guard let array = PetHospital(json: hospitalResult) else {return}
                            self.hospitalArray.append(array)
                        }
                        self.tableView.reloadData()
                    }
                }
            }catch{
                
            }
        }
        task.resume()
    }
    
}


extension PetHospitalTableViewController {
    func setSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchWord = searchController.searchBar.text else {return}
        searchResult = hospitalArray.filter({ (result) -> Bool in
            if result.hospitalName.contains(searchWord){
                return true
            }else if result.hospitalAddress.contains(searchWord){
                return true
            }else{
                return false
            }
        })
        tableView.reloadData()
    }
}
