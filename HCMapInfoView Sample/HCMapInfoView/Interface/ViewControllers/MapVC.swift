//
//  MapVC.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/21/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setNavigationBar()
        
        mapView.delegate = self
        self.addMapPins()
    }
    
    func setNavigationBar()
    {
        navigationController?.navigationBar.isTranslucent = true
        let leftImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 118, height: 25))
        leftImageButton.setBackgroundImage(#imageLiteral(resourceName: "hc_map_info_view_logo"), for: .normal)
        leftImageButton.isUserInteractionEnabled = false
        let leftBarButtonItem = UIBarButtonItem(customView: leftImageButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 125, height: 25))
        rightImageButton.setBackgroundImage(#imageLiteral(resourceName: "hypercubeLogo"), for: .normal)
        rightImageButton.addTarget(self, action: #selector(self.openHypercubeSoftWebPage), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: rightImageButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.barTintColor = UIColor(red: 10.0 / 255.0, green: 146.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func openHypercubeSoftWebPage()
    {
        UIApplication.shared.openURL(URL(string: "http://www.hypercubesoft.com")!)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func addMapPins()
    {
        // Create and add simple annotation
        mapView.addAnnotation(MKPointAnnotation(title: "School", subtitle: "Business school", coordinate: CLLocationCoordinate2D(latitude: 20.0, longitude: 100.0)))
        
        // Create and add HCAnnotations
        mapView.addAnnotation(HCAnnotation(title: "Peter", subtitle: "Doctor", coordinate: CLLocationCoordinate2D(latitude: 62.0, longitude: 7.0)))
        mapView.addAnnotation(Animal(name:"Rover", type:"Dog", coordinate:CLLocationCoordinate2D(latitude: 39.0, longitude: -99.0), age:2, image:#imageLiteral(resourceName: "dog")))
        mapView.addAnnotation(Animal(name:"Holly", type:"Cat", coordinate:CLLocationCoordinate2D(latitude: 53.0, longitude: 83.0), age:1, image:#imageLiteral(resourceName: "cat")))
        mapView.addAnnotation(Man(name:"John", profession:"Engineer", coordinate:CLLocationCoordinate2D(latitude: -34.0, longitude: -65.0), userPoints:12345, userImage:#imageLiteral(resourceName: "man")))
        mapView.addAnnotation(Man(name:"Ema", profession:"Professor", coordinate:CLLocationCoordinate2D(latitude: -20.0, longitude: 15.0), userPoints:43210, userImage:#imageLiteral(resourceName: "woman")))
    }
    
    // MARK: - MKMapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let man = annotation as? Man
        {
            // Create pin for red user
            return HCAnnotationView.hcCreatePin(forMap: mapView, forAnnotation: annotation, withPinImage:#imageLiteral(resourceName: "redMapPin"), withReuseIdentifier:"ManMapPin", withClass: MapInfoManView.self, mapInfoViewName: "MapInfoManView", showInfoViewHandler: {infoView in
                if let redView = infoView as? MapInfoManView
                {
                    redView.update(withMan: man)
                }
            })
        }
        else if let animal = annotation as? Animal
        {
            // Create pin for blue user
            return HCAnnotationView.hcCreatePin(forMap: mapView, forAnnotation: annotation, withPinImage:#imageLiteral(resourceName: "blueMapPin"), withReuseIdentifier:"AnimalMapPin", withClass: MapInfoAnimalView.self, mapInfoViewName: "MapInfoAnimalView", showInfoViewHandler: {infoView in
                if let blueView = infoView as? MapInfoAnimalView
                {
                    blueView.update(withAnimal: animal)
                }
                        
            })
        }
        else if let singleAnnotation = annotation as? HCAnnotation
        {
            // Create classic pin which can show custom info view
            return HCPinAnnotationView.hcCreateDefaultPin(forMap: mapView, forAnnotation: annotation, withPinColor: UIColor.hcColorWithHex("389E13"), withReuseIdentifier: "GreenMapPin", withClass: MapInfoGreenView.self, mapInfoViewName: "MapInfoGreenView", showInfoViewHandler: {infoView in
                if let greenView = infoView as? MapInfoGreenView
                {
                    greenView.update(withAnnotation: singleAnnotation)
                }
            })
        }
        else
        {
            // Create classic pin which cant show custom info view, it will show native callout
            return HCPinAnnotationView.hcCreateDefaultPin(forMap: mapView, forAnnotation: annotation, withReuseIdentifier: "BasicMapPin")
        }
    }
}
