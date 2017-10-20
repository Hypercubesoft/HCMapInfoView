//
//  HCViewController.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

// MARK: - UIViewController extension
extension UIViewController
{
    /// Allows you to close the keyboard on a tap anywhere within the controller.
    open func hcHideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hcDismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Close the keyboard
    @objc open func hcDismissKeyboard()
    {
        view.endEditing(true)
    }
    
    /// Set navigation header title and title text color.
    ///
    /// - Parameters:
    ///   - title: Title for the navigaton header
    ///   - textColor: Text color for the navigaton header
    open func hcSetNavigationHeader(title:String, textColor:UIColor)
    {
        let headerLabel = UILabel()
        headerLabel.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 33.0)
        headerLabel.textAlignment = .center
        headerLabel.text = title
        headerLabel.textColor = textColor
        self.navigationItem.titleView = headerLabel
    }
    
    /// Set Navigation Bar leftIcon, leftAction, rightIcon and rightAction
    ///
    /// - Parameters:
    ///   - leftIcon: Left icon image for the navigaton bar
    ///   - leftAction: Left action for the navigaton bar
    ///   - rightIcon: Right icon image for the navigaton bar
    ///   - rightAction: Right action for the navigaton bar
    open func hcSetNavigationBar(leftIcon:UIImage, leftAction:Selector?, rightIcon:UIImage, rightAction:Selector?)
    {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftIcon, style: .plain, target: self, action: leftAction)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon, style: .plain, target: self, action: rightAction)
    }
}
