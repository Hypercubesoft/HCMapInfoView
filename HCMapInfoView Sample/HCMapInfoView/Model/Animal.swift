//
//  BlueUser.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/22/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import CoreLocation

class Animal: HCAnnotation {
    var age:Int = 0
    var image:UIImage?
    
    var name:String {
        get {
            return title ?? "No name"
        }
        set {
            title = newValue
        }
    }
    
    var type:String {
        get {
            return subtitle ?? "No type"
        }
        set {
            subtitle = newValue
        }
    }
    
    convenience init(name:String, type:String, coordinate:CLLocationCoordinate2D, age:Int, image:UIImage?)
    {
        self.init(title: name, subtitle: type, coordinate: coordinate)
        self.age = age
        self.image = image
    }
}
