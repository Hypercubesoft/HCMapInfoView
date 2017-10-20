//
//  HCMapInfoViewSettings.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import MapKit

class HCMapInfoViewSettings: NSObject {

    // MARK: - Properties
    
    /// Reference to annotation (HCAnnotation instance) which is represented on map with this annotation view
    var hcAnnotation:HCAnnotation?
    
    /// Class which defines HCMapInfoView subclass for custom map info view
    var mapInfoViewType:HCMapInfoView.Type?
    
    /// Nib name for custom map info view
    var mapInfoViewNibName:String?
    
    /// Defines if callout or custom info view should be shown when annotation view is selected
    var showCallout: Bool = true
    
}
