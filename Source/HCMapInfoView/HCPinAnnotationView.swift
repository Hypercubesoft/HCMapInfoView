//
//  HCPinAnnotationView.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import MapKit

/// HCPinAnnotationView class
/// =========================
/// Custom MKPinAnnotationView class used for handling custom info views
open class HCPinAnnotationView: MKPinAnnotationView, HCAnnotationDelegate
{
    // MARK: - Properties & HCAnnotationDelegate properties
    
    /// Custom info view sizeHan
    var infoViewSize: CGSize?
    
    /// Handler which is called when info view is presented
    var showInfoViewCompletionHandler:ShowInfoViewCompletionHandler?
    
    /// Settings for presenting custom map info view
    var settings = HCMapInfoViewSettings()
    
    // MARK: - Override some basic methods
    
    /// Override point(inside:with:) method
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.isInside(point:point, event:event)
    }
    
    /// Override setSelected(_:animated:) method
    override open func setSelected(_ selected: Bool, animated: Bool) {
        self.setSelectedState(selected: selected)
    }
    
    // MARK: - Create default pin (annotation view)
    
    /// Create default map pin, i.e. MKPinAnnotationView instance
    ///
    /// - Parameters:
    ///   - map: Reference to MKMapView instance where pin has to be placed.
    ///   - annotation: Annotation for which we need to create pin.
    ///   - pinColor: Pin color. The default value is red color (default system color).
    ///   - reuseIdentifier: Reuse identifier for annotation view.
    ///   - showCallout: Defines if callout or custom info view should be shown when annotation view is selected.
    ///   - mapInfoViewClass: Class which defines HCMapInfoView subclass for custom map info view.
    ///   - mapInfoViewNibName: Nib name for custom map info view.
    ///   - infoViewSize: Desired size for info view. If not defined, the view will use its size from the nib file.
    ///   - showInfoViewHandler: Handler for showing info view. The intention is to use this handler to update the generated view with desired data.
    /// - Returns: Default pin, i.e. HCPinAnnotationView instance
    open static func hcCreateDefaultPin<T:HCMapInfoView>(forMap map:MKMapView, forAnnotation annotation:MKAnnotation, withPinColor pinColor:UIColor? = nil, withReuseIdentifier reuseIdentifier:String, showCallout:Bool = true, withClass mapInfoViewClass:T.Type? = nil, mapInfoViewName mapInfoViewNibName:String? = nil, infoViewSize:CGSize? = nil, showInfoViewHandler:ShowInfoViewCompletionHandler? = nil) -> HCPinAnnotationView?
    {
        var pin = map.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? HCPinAnnotationView
        if pin == nil
        {
            pin = HCPinAnnotationView.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        if let hcAnnotation = annotation as? HCAnnotation
        {
            hcAnnotation.hcPinAnnotationView = pin
            if let hcPinAnnotationView = hcAnnotation.hcPinAnnotationView
            {
                pin?.settings.hcAnnotation = hcAnnotation

                hcPinAnnotationView.settings.mapInfoViewNibName = mapInfoViewNibName
                hcPinAnnotationView.settings.mapInfoViewType = mapInfoViewClass
                hcPinAnnotationView.settings.showCallout = showCallout
            }
        }
        pin?.pinTintColor = pinColor
        if mapInfoViewClass != nil && mapInfoViewNibName != nil
        {
            pin?.canShowCallout = false
        }
        else
        {
            pin?.canShowCallout = true
        }
        pin?.infoViewSize = infoViewSize
        pin?.showInfoViewCompletionHandler = showInfoViewHandler
        
        return pin
    }

}
