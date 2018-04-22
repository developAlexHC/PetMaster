//
//  HospitalLocationViewController.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/4/20.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HospitalLocationViewController: UIViewController{

    var hospitalAddress: PetHospital?
    var setNavigation:CLLocationCoordinate2D?
    var userLocationCoordinate:CLLocationCoordinate2D?
    var userLocation:CLLocationManager?
    @IBOutlet weak var hospitalMapView: MKMapView!
    
    @IBAction func navigationButton(_ sender: Any) {
        navigationFun()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapView()
        //getUserLocation()
    }
    
    
    func getUserLocation() {
        userLocation = CLLocationManager()
        userLocation?.requestWhenInUseAuthorization()
        userLocation?.desiredAccuracy = kCLLocationAccuracyBest
        userLocationCoordinate = userLocation?.location?.coordinate
        
        let xScale:CLLocationDegrees = 0.01
        let yScale:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(xScale, yScale)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocationCoordinate!, span)
        hospitalMapView.setRegion(region, animated: true)
        
        
    }
    func setMapView() {
        guard let address = hospitalAddress else {return}
        getCoordinate(address.hospitalAddress) { (location) in
            guard let location = location else {return}
            self.setNavigation = location
            let xScale:CLLocationDegrees = 0.01
            let yScale:CLLocationDegrees = 0.01
            let span:MKCoordinateSpan = MKCoordinateSpanMake(xScale, yScale)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.hospitalMapView.setRegion(region, animated: true)
            self.hospitalMapView.isZoomEnabled = true
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = address.hospitalName
            annotation.subtitle = address.hospitalAddress
            self.hospitalMapView.addAnnotation(annotation)
        }
    }
    
    func getCoordinate(_ address:String, completion: @escaping (CLLocationCoordinate2D?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }

    func navigationFun() {
        guard let setDestination = setNavigation else {return}
        
        let taipei101 = CLLocationCoordinate2DMake(25.033850, 121.564977)
        let airstation = setDestination
        if let userLocation = userLocationCoordinate {
            let pA = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
            let pB = MKPlacemark(coordinate: airstation, addressDictionary: nil)
            
            let miA = MKMapItem(placemark: pA)
            let miB = MKMapItem(placemark: pB)
            miA.name = "我的位置"
            miB.name = hospitalAddress?.hospitalName
            
            let route = [miA,miB]
            let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: route, launchOptions: options)
        }else{
            print("error")
        }
       
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


extension HospitalLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annView = hospitalMapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "telephone"))
        annView?.rightCalloutAccessoryView = imageView
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callOutButton)))
        imageView.isUserInteractionEnabled = true
        
        annView?.canShowCallout = true
        return annView
    }
    
    @objc func callOutButton() {
        if let number = hospitalAddress?.hospitalNumber {
            let newNumber = number.trimmingCharacters(in: .whitespaces)
            let url = URL(string: "tel://\(newNumber)" )
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }else{
            print("Error")
        }
    }
    
}
