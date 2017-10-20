//
//  HCMapInfoView.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/21/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

/// HCMapInfoView class
/// =========================
/// Custom UIView class which has to be subclassed and used as a class for custom info view.
class HCMapInfoView: UIView {

    // MARK: - Override checking touch events
    
    /// Override hitTest(_:with:) method
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitTest = super.hitTest(point, with: event)
        {
            superview?.bringSubview(toFront: self)
            return hitTest
        }
        return nil
    }
    
    /// Override point(inside:with:) method
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isTouchableAtThisPoint: Bool = self.alpha(fromPoint: point) > 0
        return isTouchableAtThisPoint
    }
    
    /// Get alpha component of a color picked at specific point in a view. The idea is to disable touch inside this view if user has tapped in transparent area of this view
    ///
    /// - Parameter point: Posiotion in a view for which we have to check the color
    /// - Returns: Alpha component of color picked at given point
    func alpha(fromPoint point: CGPoint) -> CGFloat
    {
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context!.translateBy(x: -point.x, y: -point.y)
        self.layer.render(in: context!)
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        return alpha
    }
    
}
