//
//  HCAnnotation.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import MapKit

/// HCAnnotation class
/// =========================
/// Custom MKPointAnnotation class which handles custom map info views, i.e. saves custom map info view properties
open class HCAnnotation: MKPointAnnotation
{
    // MARK: - Properties
    
    /// HCAnnotationView instance, i.e. reference to annotation view on map
    var hcAnnotationView:HCAnnotationView?
    
    /// HCPinAnnotationView instance, i.e. reference to pin annotation view on map
    var hcPinAnnotationView:HCPinAnnotationView?
    
    /// Boolean value which indicates if custom info view is visible. This is useful in case where we need to handle annotations reusability, so we can show custom info view if needed.
    var infoViewIsVisible = false
    
    /// Custom info view frame, which is used in case where we need to handle annotations reusability, so we can show custom info view with accurate frame if needed.
    var infoViewFrame:CGRect?
    
    /// Reference to custom info view
    var mapInfoView:HCMapInfoView?
    
}
