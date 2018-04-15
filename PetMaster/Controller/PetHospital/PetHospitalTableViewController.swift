//
//  PetHospitalTableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/4/15.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetHospitalTableViewController: UITableViewController {

    var hospitalArray = [PetHospital]()
    let petHospitalUrlStr = "https://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=078&$top=1000&$skip=0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        downloadHospital(urlstr: petHospitalUrlStr)
        print(hospitalArray.count)
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
                    for hospitalResult in result {
                        guard let array = PetHospital(json: hospitalResult) else {return}
                        self.hospitalArray.append(array)
                    }
                }
               
            }catch{
                
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hospitalArray.count
        
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: propertyKey.petHospitalCell, for: indexPath)
        cell.textLabel?.text = hospitalArray[indexPath.row].hospitalName
        return cell
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
