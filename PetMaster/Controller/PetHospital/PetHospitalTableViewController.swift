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
    let petHospitalUrlStr = "https://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=078&$top=1000&$skip=0"
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadHospital(urlstr: petHospitalUrlStr)
        
        self.searchController = UISearchController(searchResultsController: self.searchController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
    }

    func updateSearchResults(for searchController: UISearchController) {
        
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

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: propertyKey.petHospitalCell, for: indexPath) as? PetHospotalTableViewCell {
            let hospitalIndex = hospitalArray[indexPath.row]
            cell.nameLabel.text = hospitalIndex.hospitalName
            cell.addressLabel.text = hospitalIndex.hospitalAddress
            cell.numberLabel.text = hospitalIndex.hospitalNumber
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hospitalLocationVC = segue.destination as? HospitalLocationViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                hospitalLocationVC.hospitalAddress = hospitalArray[indexPath.row]
            }
        }
    }

}
