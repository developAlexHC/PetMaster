//
//  Edit_TableViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/1.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase

protocol AddOrEditPlayerDeledate {
    func update(pet:PetInfo)
}
class Edit_TableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

  
    var genderSelect = [Gender.male, Gender.female]
    var genderPicker = UIPickerView()
    var birthDatePicker = UIDatePicker()
    var addDelegate: AddOrEditPlayerDeledate?
    var pet = [PetInfo]()
    
    @IBOutlet weak var petName_TextField: UITextField!
    @IBOutlet weak var petGender_TextField: UITextField!
    @IBOutlet weak var petType_TextField: UITextField!
    @IBOutlet weak var petBreed_TextField: UITextField!
    @IBOutlet weak var petColor_TextField: UITextField!
    @IBOutlet weak var petBirthday_TextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    //-----------------------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderSelect.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderSelect[row].rawValue
 
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        petGender_TextField.text = genderSelect[row].rawValue
        
    }
    //-----------------------------------------------------------

    
    
    @IBAction func doneButton(_ sender: Any) {
        
        /*
        if let pet_name = petName_TextField.text, let pet_gender = petBirthday_TextField.text, let pet_type = petType_TextField.text, let pet_Breed = petBreed_TextField.text, let pet_color = petColor_TextField.text,let pet_birth = petBirthday_TextField.text, pet_name.count > 0 && pet_gender.count > 0 && pet_type.count > 0 && pet_Breed.count > 0 && pet_color.count > 0 && pet_birth.count > 0  {
            
            let newPet = PetInfo(petName: pet_name, petGender: pet_gender , petType: pet_type, petBreed: pet_Breed, petColor: pet_color, petBirthday: pet_birth, petIndex: nil, petImage: nil)
            addDelegate?.update(pet: newPet)
            print("新增成功:\(newPet.petName)")
           
            let alert = UIAlertController(title: "Done", message:"新增完成", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (Alert) in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            
        }else{
            popAlert(withTittle: "Error", AndMessage: "新增錯誤")
            print("addError")
        }
        */
        
//        let ref: DatabaseReference! = Database.database().reference().child("Pets")
//
//        var petReview: [String : AnyObject] = [String : AnyObject]()
//        petReview["petName"] = petName_TextField.text as AnyObject
//        petReview["petGender"] = petGender_TextField.text as AnyObject
//        petReview["petType"] = petType_TextField.text as AnyObject
//        petReview["petBreed"] = petBreed_TextField.text as AnyObject
//        petReview["perColor"] = petColor_TextField.text as AnyObject
//        petReview["petBirthday"] = petBirthday_TextField.text as AnyObject
//        petReview["petIndex"] = "01" as AnyObject
//
//
//        let childRef: DatabaseReference! = ref.childByAutoId()
//        let autoID = ref.child(childRef.key)
//
//        autoID.updateChildValues(petReview) { (error, ref) in
//            if  error != nil {
//                print("Err\(error!)")
//                return
//            }
//            print(ref.description())
        
        let parameters = ["petName"     : petName_TextField.text  ,
                          "petGender"   : petGender_TextField.text,
                          "petType"     : petType_TextField.text  ,
                          "petBreed"    : petBreed_TextField.text ,
                          "petColor"    : petColor_TextField.text ,
                          "petBorn"     : petBirthday_TextField.text]
        
        DatabaseService.share.petRenfence.childByAutoId().setValue(parameters) { (error, ref) in
            if error != nil {
                print("error\(error)")
                self.popAlert(withTittle: "錯誤", AndMessage: "新增錯誤")
                return
            }
            print(ref.description())
            let alert = UIAlertController(title: "Done", message:"新增完成", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (Alert) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
 
 
    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
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
 
    
    func cameraError() {
        let cameraError = UIAlertController(title: "錯誤", message: "找不到相機", preferredStyle: .alert)
        cameraError.addAction(UIAlertAction(title: "Cancal", style: .cancel, handler: nil))
        present(cameraError, animated: true, completion: nil)
    }
    
    func popAlert(withTittle title:String, AndMessage message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAciton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAciton)
        present(alert, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            addPhotoButton.setImage(image, for: .normal)
        }else{
            addPhotoButton.setImage(UIImage(named: "dog"), for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func createDatePiclker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        petBirthday_TextField.inputAccessoryView = toolbar
        petBirthday_TextField.inputView = birthDatePicker
        
        birthDatePicker.datePickerMode = .date
        birthDatePicker.locale = Locale(identifier: "zh_TW")
        
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月dd日"
        let dateString = formatter.string(from: birthDatePicker.date)
        
        petBirthday_TextField.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    
    func textPlachHolder(){
        petType_TextField.placeholder = "狗,貓..."
        petBreed_TextField.placeholder = "法鬥,柯基,英國短毛貓..."
        petColor_TextField.placeholder = "灰色,黃色,長毛,短毛..."
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        petGender_TextField.inputView = genderPicker
        
        createDatePiclker()
        textPlachHolder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
