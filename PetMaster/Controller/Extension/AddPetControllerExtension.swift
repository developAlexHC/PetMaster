//
//  AddPetControllerExtension.swift
//  
//
//  Created by Alex Hsieh on 2018/3/15.
//

import UIKit
import Firebase

extension AddPet_TableViewController {
    
    func uploadPetProgileFromDoneButton() {
        
        guard let pet_name = petName_TextField.text, let pet_gender = petGender_TextField.text, let pet_type = petType_TextField.text, let pet_Breed = petBreed_TextField.text, let pet_color = petColor_TextField.text,let pet_born = petBirthday_TextField.text else { return }
        
        if pet_name.isEmpty && pet_gender.isEmpty && pet_type.isEmpty && pet_Breed.isEmpty && pet_color.isEmpty && pet_born.isEmpty {
            showMsg("欄位不得空白")
        }else{
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            //upload pet image
            let petImageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("PetImage").child("\(petImageName).jpg")
            guard let uploadData = UIImageJPEGRepresentation(self.petImageView.image!, 0.1) else {return}
            storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                if error != nil {
                    print("putdata error:\(error!)")
                }
                
                guard let petProfileImageUrl = metaData?.downloadURL()?.absoluteString else {return}
                
                //upload background
                let petBackgroungImage = NSUUID().uuidString
                let storageRefPetBackground = Storage.storage().reference().child("petBackground").child("\(petBackgroungImage).jpg")
                guard let uploadPetBackground = UIImageJPEGRepresentation(self.petBackgroundImage.image!, 0.2) else {return}
                storageRefPetBackground.putData(uploadPetBackground, metadata: nil, completion: { (matadataBackground, err) in
                    if err != nil {
                        print(err!)
                    }
                    guard let petBackgroundUrl = matadataBackground?.downloadURL()?.absoluteString else {return}
                    
                    let parameters = ["petName"     : pet_name  ,
                                      "petGender"   : pet_gender,
                                      "petType"     : pet_type  ,
                                      "petBreed"    : pet_Breed ,
                                      "petColor"    : pet_color ,
                                      "petBorn"     : pet_born  ,
                                      "petImage"    : petProfileImageUrl,
                                      "petBackground": petBackgroundUrl
                                     ]
                    
                    self.uploadPetProfileIntoDatabaseWithUID(uid: uid, parameters: parameters)
                })
            }
        }
    }
    
    func uploadPetProfileIntoDatabaseWithUID(uid:String, parameters:[String : Any]){
        
        FirebaseService.share.userRenfence.child(uid).child("pets").childByAutoId().setValue(parameters) { (error, ref) in
            if error != nil {
                print("error")
                return
            }
            
            let alert = UIAlertController(title: "Done", message:"新增完成", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (Alert) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func handleSelectPetProfileImage(){
        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self
        imagePickController.allowsEditing = true
        
        
        let addPhoto = UIAlertController(title: "請選擇一張圖片", message: "相機或照片圖庫", preferredStyle: .actionSheet)
        addPhoto.addAction(UIAlertAction(title: "相機", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickController.sourceType = .camera
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        
        if let EditImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = EditImage
        }else if let originImage = info["UIImagePickerControllerOriginImage"] as? UIImage {
            selectedImageFromPicker = originImage
        }
        
        guard let selectedImage = selectedImageFromPicker else { return }
        if imagePiked == 0{
            petBackgroundImage.image = selectedImage
        }else if imagePiked == 1{
             petImageView.image = selectedImage
        }
       
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func cameraError() {
        let cameraError = UIAlertController(title: "錯誤", message: "找不到相機", preferredStyle: .alert)
        cameraError.addAction(UIAlertAction(title: "Cancal", style: .cancel, handler: nil))
        present(cameraError, animated: true, completion: nil)
    }
    
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
