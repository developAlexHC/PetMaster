//
//  HomeControllerExtension.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/4/6.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import Foundation
import Firebase
import UIKit

extension Home_ViewController {
    
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
    
}
