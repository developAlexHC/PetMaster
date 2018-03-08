//
//  PetCell_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/2.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class PetCell_ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UIScrollViewDelegate, AddOrEditPlayerDeledate {

    func update(pet:PetInfo) {
        Pets.insert(pet, at: 0)
        collectionView.reloadData()
        print("pet")
    }
    
    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct propertyKey {
        static let petCell = "PetCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Disposeof any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        page.numberOfPages = Pets.count
        page.isHidden = !(Pets.count > 1
        )
        return Pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: propertyKey.petCell, for: indexPath) as? Pet_CollectionViewCell else {fatalError("Error")}
        
        cell.pet_Image_Cell.clipsToBounds = true
        cell.pet_Image_Cell.layer.cornerRadius = 95
        cell.viewBackground.layer.cornerRadius = 30
        
        page.numberOfPages = Pets.count
        
        let pet = Pets[indexPath.row]
        cell.pet_Name_Cell.text = pet.petName
        cell.pet_gender_Cell.image = UIImage(named: "\(pet.petGender)")
        cell.pet_Breed_Cell.text = pet.petBreed
        if let petImage = pet.petImage{
            cell.pet_Image_Cell.image = UIImage(named: petImage)
        }else{
            cell.pet_Image_Cell.image = #imageLiteral(resourceName: "dog")
        }
        
        
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        page.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
         page.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
   
    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let Detail_TVC = segue.destination as? Pet_Detail_TableViewController{
            
        }
    }
    */

}
