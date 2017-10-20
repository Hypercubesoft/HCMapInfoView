//
//  MKAnnotationExtension.swift
//  HCMapInfoView
//
//  Created by Hypercube 2 on 10/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import MapKit

/// MKPointAnnotation extension
/// =========================
/// This MKPointAnnotation extension is used to implement additional constructor / initializer
extension MKPointAnnotation
{
    /// Constructor / initializer
    ///
    /// - Parameters:
    ///   - title: Annotation title
    ///   - subtitle: Annotation subtitle
    ///   - coordinate:  Annotation coordinate
    convenience init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D)
    {
        self.init()
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
