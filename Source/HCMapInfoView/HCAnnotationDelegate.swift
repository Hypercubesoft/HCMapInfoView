//
//  HCAnnotationDelegate.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import MapKit
import HCFramework

/// Typealias for handler which is called when info view is presented
typealias ShowInfoViewCompletionHandler = (_ infoView: HCMapInfoView) -> Void

/// HCAnnotationDelegate protocol used for extending HCAnnotationView and HCPinAnnotationView classes
protocol HCAnnotationDelegate where Self:MKAnnotationView
{
    /// Settings for presenting custom map info view
    var settings:HCMapInfoViewSettings { get }
    
    /// Handler which is called when info view is presented
    var showInfoViewCompletionHandler:ShowInfoViewCompletionHandler? {get}
    
    /// Custom info view size
    var infoViewSize:CGSize? {get}
}

/// Extension for HCAnnotationDelegate where we have implemented some helper methods for presenting custom map info views
extension HCAnnotationDelegate
{
    
    // MARK: - Helper methods
    
    /// Helper method for getting reference to hcAnnotation
    func hcAnnotation() -> HCAnnotation?
    {
        return self.settings.hcAnnotation
    }
    
    // MARK: - Helper methods for overriding basic methods
    
    /// Helper method for overriding setSelected(_:animated:) method method for HCAnnotationView and HCPinAnnotationView classes
    ///
    /// - Parameter selected: Contains the value true if the view should display itself as selected.
    func setSelectedState(selected:Bool)
    {
        guard self is HCAnnotationView || self is HCPinAnnotationView else { return }
        if selected
        {
            if let infoView = self.showInfoView(), let completion = showInfoViewCompletionHandler
            {
                completion(infoView)
            }
        }
        else
        {
            let subviews = self.subviews
            for singleSubview in subviews
            {
                singleSubview.removeFromSuperview()
            }
        }
    }

    /// Helper method for overriding point(inside:with:) method
    ///
    /// - Parameters:
    ///   - point: A point that is in the receiver’s local coordinate system (bounds).
    ///   - event: The event that warranted a call to this method. If you are calling this method from outside your event-handling code, you may specify nil.
    /// - Returns: true if point is inside the receiver’s bounds; otherwise, false.
    func isInside(point: CGPoint, event: UIEvent?) -> Bool
    {
        guard self is HCAnnotationView || self is HCPinAnnotationView else { return false }
        let rect: CGRect = bounds
        var isInside: Bool = rect.contains(point)
        if !isInside {
            for view: UIView in subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    break
                }
            }
        }
        return isInside
    }
    
    // MARK: - Presenting custom map info view
    
    /// Show custom map info view, i.e. HCMapInfoView instance
    ///
    /// - Returns: Presented custom map info view, i.e. HCMapInfoView instance
    func showInfoView() -> HCMapInfoView?
    {
        guard (self is HCAnnotationView || self is HCPinAnnotationView) && settings.showCallout else { return nil }
        self.isUserInteractionEnabled = true
        if let mapInfoViewNibName = settings.mapInfoViewNibName
        {
            if let mapInfoView = HCMapInfoView.hcLoadFromNib(named: mapInfoViewNibName) as? HCMapInfoView
            {
                let customInfoViewSize = infoViewSize != nil ? infoViewSize! : mapInfoView.frame.size
                if self is HCPinAnnotationView
                {
                    self.showMapInfo(mapInfoView:mapInfoView, frame: CGRect(x: -customInfoViewSize.width * 0.5 + self.centerOffset.x, y: -customInfoViewSize.height + 5.0, width: customInfoViewSize.width, height: customInfoViewSize.height), annotation: settings.hcAnnotation!)
                }
                else if self is HCAnnotationView
                {
                    self.showMapInfo(mapInfoView:mapInfoView, frame: CGRect(x: -customInfoViewSize.width * 0.5 + (self.image?.size.width ?? 30.0) * 0.5, y: -customInfoViewSize.height + 5.0, width: customInfoViewSize.width, height: customInfoViewSize.height), annotation: settings.hcAnnotation!)
                }
                return mapInfoView
            }
        }
        return nil
    }
    
    
    /// Helper method for showing custom info view
    ///
    /// - Parameters:
    ///   - mapInfoView: Custom info view which has to be presented
    ///   - frame: Frame for custom info view
    ///   - annotation: Annotation for which we are presenting custom info view
    func showMapInfo(mapInfoView:HCMapInfoView, frame:CGRect, annotation:HCAnnotation)
    {
        guard self is HCAnnotationView || self is HCPinAnnotationView else { return }
        if self.subviews.count == 0
        {
            if let selfPinAnnotationView = self as? HCPinAnnotationView
            {
                annotation.hcPinAnnotationView = selfPinAnnotationView
            }
            else if let selfAnnotationView = self as? HCAnnotationView
            {
                annotation.hcAnnotationView = selfAnnotationView
            }
            annotation.mapInfoView = mapInfoView
            annotation.infoViewIsVisible = true
            mapInfoView.frame = frame
            self.addSubview(mapInfoView)
            annotation.infoViewFrame = frame
        }
    }
}
