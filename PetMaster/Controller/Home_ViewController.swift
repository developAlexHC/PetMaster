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
 //       databaseLoadData()
        checkUserIsLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkUserIsLogin()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        handleLogout()
    }
    func checkUserIsLogin(){
        if Auth.auth().currentUser?.uid == nil{
          handleLogout()
        }
        fetchUserSetTitle()
    }
    
    func handleLogout() {
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
        performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    
    func fetchUserSetTitle(){
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
        collectionView.reloadData()
        databaseLoadData()

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

    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd/"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .chinese)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
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
        cell.pet_Image_Cell.layer.cornerRadius = 50
        
        cell.viewBackground.layer.shadowOffset = CGSize(width: 3, height: 5)
        cell.viewBackground.layer.shadowOpacity = 0.7
        cell.viewBackground.layer.shadowRadius = 4
        cell.viewBackground.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        cell.viewBackground.layer.cornerRadius = 8
        cell.viewBackground.layer.borderWidth = 1
        cell.viewBackground.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        
        cell.petBackgroundImage.image = UIImage(named: "IMG_3350")
        cell.petBackgroundImage.layer.cornerRadius = 8
        cell.petBackgroundImage.contentMode = .scaleAspectFill
        
        page.numberOfPages = pets.count

        let pet = pets[indexPath.row]
        cell.pet_Name_Cell.text = pet.petName
        
        cell.pet_Breed_Cell.text = pet.petBreed
        cell.pet_Age_Cell.text = "\(calcAge(birthday: pet.petBorn))歲"
        cell.pet_Birth_Cell.text = pet.petBorn
        
        if pet.petGender == "男生" {
            cell.pet_gender_Cell.image = UIImage(named:"male")
        }else {
            cell.pet_gender_Cell.image = UIImage(named:"female")
        }
        if let petImageURL = pet.petImage {
            cell.pet_Image_Cell.loadImageUsingCacheWithUrlString(urlString: petImageURL)
        }

        if let petBackgroundURL = pet.petBackgroundImage {
            cell.petBackgroundImage.loadImageUsingCacheWithUrlString(urlString: petBackgroundURL)
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
            
        }
    }

}

