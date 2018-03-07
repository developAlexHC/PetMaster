//
//  Edit_TableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/1.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class Edit_TableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var petName_TextField: UITextField!
    @IBOutlet weak var petGender_TextField: UITextField!
    @IBOutlet weak var petType_TextField: UITextField!
    @IBOutlet weak var petBreed_TextField: UITextField!
    @IBOutlet weak var petColor_TextField: UITextField!
    @IBOutlet weak var petBirthday_TextField: UITextField!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addPhotoButton(_ sender: Any) {
   
        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self
        
        let addPhoto = UIAlertController(title: "請選擇一張圖片", message: "相機或照片圖庫", preferredStyle: .actionSheet)
        
        addPhoto.addAction(UIAlertAction(title: "相機", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickController.sourceType = .camera
                imagePickController.allowsEditing = true
                self.present(imagePickController, animated: true, completion: nil)
            }else{
                self.cameraError()
            }
        }))
        
        addPhoto.addAction(UIAlertAction(title: "照片圖庫", style: .default, handler: { (UIAlertAction) in
            imagePickController.sourceType = .photoLibrary
            imagePickController.allowsEditing = true
             self.present(imagePickController, animated: true, completion: nil)
        }))
        
        addPhoto.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(addPhoto, animated: true, completion: nil)
        
      
    }
    
    func setButtonImage (){
        if petImage.image != nil {
            addPhotoButton.setImage(UIImage(named: ""), for: .normal)
        }else{
            addPhotoButton.setImage(UIImage(named: "AddPhoto_1"), for: .normal)
        }
    }
    
    func cameraError() {
        let cameraError = UIAlertController(title: "錯誤", message: "找不到相機", preferredStyle: .alert)
        cameraError.addAction(UIAlertAction(title: "Cancal", style: .cancel, handler: nil))
        present(cameraError, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            petImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setButtonImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
