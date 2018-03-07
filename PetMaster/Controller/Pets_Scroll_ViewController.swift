//
//  Pets_Scroll_ViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/6.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

class Pets_Scroll_ViewController: UIViewController {

    @IBOutlet weak var pet_ScrollView: UIScrollView!
    
    //let petCards = pet
    override func viewDidLoad() {
        super.viewDidLoad()

        pet_ScrollView.isPagingEnabled = true
        pet_ScrollView.showsHorizontalScrollIndicator = false
        pet_ScrollView.layer.cornerRadius = 30
        
        pet_ScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(Pets.count), height: 500)
        
        load_Scroll()
        
    }

    func load_Scroll() {
        for index in 0...Pets.count-1 {
            if let petCard = Bundle.main.loadNibNamed("Pets_View", owner: self, options: nil)?.first as? Pets_View{
                
                petCard.pets_name.text = Pets[index].petName
                petCard.pets_Gender.image = UIImage(named: "\(Pets[index].petGender)")
                petCard.pets_Breed.text = Pets[index].petBreed
                print("index:\(Pets[index].petName)")
                if let petImageIndex = Pets[index].petIndex {
                    petCard.pets_Image.image = UIImage(named: petImageIndex)
                }else{
                   petCard.pets_Image.image = #imageLiteral(resourceName: "dog")
                }
                
                pet_ScrollView.addSubview(petCard)
                pet_ScrollView.frame.size.width = self.view.bounds.width
                pet_ScrollView.frame.origin.x = CGFloat(index) * self.view.bounds.width
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
