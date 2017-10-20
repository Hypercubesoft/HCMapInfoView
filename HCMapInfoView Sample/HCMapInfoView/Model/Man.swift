//
//  WhiteUser.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/22/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import CoreLocation

class Man: HCAnnotation {
    
    var name:String {
        get {
            return title ?? "No name"
        }
        set {
            title = newValue
        }
    }
    
    var profession:String {
        get {
            return subtitle ?? "No address"
        }
        set {
            subtitle = newValue
        }
    }
    
    var userPoints:Int = 0
    var userImage:UIImage? = nil
    
    convenience init(name:String, profession:String, coordinate:CLLocationCoordinate2D, userPoints:Int, userImage:UIImage)
    {
        self.init(title: name, subtitle: profession, coordinate: coordinate)
        self.userPoints = userPoints
        self.userImage = userImage
    }
}
