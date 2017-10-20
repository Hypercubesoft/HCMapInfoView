//
//  HCAnnotationView.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import MapKit


/// HCAnnotationView class
/// =========================
/// Custom MKAnnotationView class used for handling custom info views
class HCAnnotationView: MKAnnotationView, HCAnnotationDelegate
{

    // MARK: - Properties & HCAnnotationDelegate properties
    
    /// Handler which is called when info view is presented
    var showInfoViewCompletionHandler:ShowInfoViewCompletionHandler?
    
    /// Settings for presenting custom map info view
    var settings = HCMapInfoViewSettings()
    
    /// Custom info view size
    var infoViewSize: CGSize?
    
    // MARK: - Override some basic methods
    
    /// Override point(inside:with:) method
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.isInside(point:point, event:event)
    }
    
    /// Override setSelected(_:animated:) method
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.setSelectedState(selected: selected)
    }
    
    // MARK: - Create custom pin (annotation view)
    
    /// Create custom map pin (annotation view)
    ///
    /// - Parameters:
    ///   - map: Reference to MKMapView instance where the pin has to be placed.
    ///   - annotation: Annotation for which we need to create pin.
    ///   - pinImage: Pin image. If this parameter is not provided, default system pin will be used.
    ///   - pinCenterOffset: Position offset for custom pin (annotation view).
    ///   - reuseIdentifier: Reuse identifier for annotation view.
    ///   - showCallout: Defines if callout or custom info view should be shown when annotation view is selected.
    ///   - mapInfoViewClass: Class which defines HCMapInfoView subclass for custom map info view.
    ///   - mapInfoViewNibName: Nib name for custom map info view.
    ///   - infoViewSize: Desired size for info view. If not defined, the view will use its size from the nib file.
    ///   - showInfoViewHandler: Handler for showing info view. The intention is to use this handler to update the generated view with desired data.
    /// - Returns: Custom pin, i.e. custom map annotation (HCAnnotationView instance).
    static func hcCreatePin<T:HCMapInfoView>(forMap map:MKMapView, forAnnotation annotation:MKAnnotation, withPinImage pinImage:UIImage? = nil, pinCenterOffset:CGPoint? = nil, withReuseIdentifier reuseIdentifier:String, showCallout:Bool = true, withClass mapInfoViewClass:T.Type? = nil, mapInfoViewName mapInfoViewNibName:String? = nil, infoViewSize:CGSize? = nil, showInfoViewHandler:ShowInfoViewCompletionHandler? = nil) -> HCAnnotationView?
    {
        var pin = map.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? HCAnnotationView
        if pin == nil
        {
            pin = HCAnnotationView.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        if let hcAnnotation = annotation as? HCAnnotation
        {
            hcAnnotation.hcAnnotationView = pin
            if let hcAnnotationView = hcAnnotation.hcAnnotationView
            {
                pin?.settings.hcAnnotation = hcAnnotation
                hcAnnotationView.settings.mapInfoViewNibName = mapInfoViewNibName
                hcAnnotationView.settings.mapInfoViewType = mapInfoViewClass
                hcAnnotationView.settings.showCallout = showCallout
            }
        }
        if let pinImage = pinImage
        {
            if let pinCenterOffset = pinCenterOffset
            {
                pin?.centerOffset = pinCenterOffset
            }
            else
            {
                pin?.centerOffset = CGPoint(x: 0.0, y: pinImage.size.height * -0.5)
            }
        }
        pin?.image = pinImage
        if !showCallout || (mapInfoViewClass != nil && mapInfoViewNibName != nil)
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
