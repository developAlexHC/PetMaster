//
//  PetCell_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/2.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import Firebase

class Home_ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UIScrollViewDelegate{


    @IBAction func unwindToFirstPage(segue: UIStoryboardSegue) { }
    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pets = [PetInfo]()
    var user = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseLoadData()
        checkUserIsLogin()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            print("signout")
        }catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
        self.user.clearAll()
        self.pets.removeAll()
        
        
        let loginController = Login_ViewController()
        loginController.homeController = self
        presentViewController(viewControllerID: propertyKey.loginview)
    }
    

    
    func checkUserIsLogin(){
        if Auth.auth().currentUser?.uid == nil{
          presentViewController(viewControllerID: propertyKey.loginview)
        }
        fetchUserSetTitle()
    }
    
    
    func fetchUserSetTitle(){
        print("fetch")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        FirebaseService.share.userRenfence.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            //print(snapshot)
            if let dict = snapshot.value as? [String: Any]{
                self.user.userName = dict["name"] as? String
                self.user.userEmail = dict["email"] as? String
                self.user.uid = snapshot.key
                self.navigationItem.title = self.user.userName
            }
        })

    }
    
    
    func databaseLoadData() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        FirebaseService.share.userRenfence.child(uid).child("pets").observe(DataEventType.value) { (snapshot) in
            //print(snapshot)
            guard let petsSnapshot = PetsSnapshot(snapshot: snapshot) else { return }
            self.pets = petsSnapshot.pets
            self.collectionView.reloadData()
        }
    }

    func presentViewController(viewControllerID:String) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: viewControllerID) else {return}
            self.present(viewController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        page.numberOfPages = pets.count
        page.isHidden = !(pets.count > 1)
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: propertyKey.petCell, for: indexPath) as? Pet_CollectionViewCell else {fatalError("Error")}
        
        cell.pet_Image_Cell.clipsToBounds = true
        cell.pet_Image_Cell.layer.cornerRadius = 95
        cell.viewBackground.layer.cornerRadius = 30
        
        page.numberOfPages = pets.count

        let pet = pets[indexPath.row]
        cell.pet_Name_Cell.text = pet.petName
        cell.pet_gender_Cell.image = UIImage(named: "male")
        cell.pet_Breed_Cell.text = pet.petBreed
        
        
        if let petImageURL = pet.petImage {
            cell.pet_Image_Cell.loadImageUsingCacheWithUrlString(urlString: petImageURL)

        }
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        page.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        page.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let petProfileVC = segue.destination as? PetProfileViewController {
            let petCell = sender as! Pet_CollectionViewCell
            guard let indexPath = self.collectionView.indexPath(for: petCell) else {return}
            petProfileVC.petProfile = pets[indexPath.row]
            print(pets[indexPath.row])
            
        }
    }

}



