//
//  HCView.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

// MARK: - UIView extension
extension UIView {
    
    /// Generic method for instantiating a view from a nib (xib) file.
    ///
    /// - Parameters:
    ///   - nibName: String value for nib (xib) file name.
    ///   - viewHolder: UIView for view holder of nib view. By default viewHolder is not set.
    /// - Returns: UIView of generic type loaded from a nib (xib) file
    @discardableResult
    open class func hcLoadFromNib<T : UIView>(named nibName:String, into viewHolder:UIView? = nil) -> T?
    {
        if let viewHolder = viewHolder
        {
            for singleSubview in viewHolder.subviews
            {
                if singleSubview.isKind(of: self)
                {
                    return nil
                }
            }
        }
        
        guard let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as? T else
        {
            return nil
        }
        if let viewHolder = viewHolder
        {
            viewHolder.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: viewHolder, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: viewHolder, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            let leftConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: viewHolder, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: viewHolder, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            
            viewHolder.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        }
        return view
    }
    
    /// Set circled corners of view. Setting will be performed with some delay, because in some cases view frame is unknown.
    open func hcSetCircled()
    {
        self.perform(#selector(hcSetCircleDelayed), with: nil, afterDelay: 0.001)
    }
    
    /// Set circled corners of view based on its frame.
    @objc private func hcSetCircleDelayed()
    {
        self.hcSetCornerRadius(cornerRadius: self.frame.size.width * 0.5)
    }
    
    /// Set rounded corners of view.
    ///
    /// - Parameter cornerRadius: CGFloat value of corner radius of view.
    open func hcSetCornerRadius(cornerRadius:CGFloat)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
