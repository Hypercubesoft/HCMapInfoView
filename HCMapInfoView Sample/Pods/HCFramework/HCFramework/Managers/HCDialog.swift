//
//  HCDialog.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

/// HCDialog class which facilitates showing dailogs, i.e. alerts
open class HCDialog: NSObject
{

    // MARK: - Dialog manipulations.
    
    /// Show dialog in root VC with specific title and message. The dialog has one action button.
    ///
    /// - Parameters:
    ///   - message: Dialog message string.
    ///   - title: Dialog title string.
    ///   - buttonTitle: Button title string. Default value is "Ok".
    open static func showDialog(message: String, title: String, buttonTitle: String = "Ok")
    {
        self.showDialogWithMultipleActions(message: message, title: title, alertButtonTitles: [buttonTitle], alertButtonActions: [nil], alertButtonStyles: [.cancel])
    }
    
    /// Show dialog in root VC with specific title and message. The dialog has two action button.
    ///
    /// - Parameters:
    ///   - message: Dialog message string.
    ///   - title: Dialog title string.
    ///   - okButtonTitle: Button title for "Ok" button. Default value is "Ok".
    ///   - action: Completion block which will be performed when the okButton is pressed.
    open static func showDialogWithAction(message: String, title: String, okButtonTitle:String = "Ok", action:((UIAlertAction) -> Void)?)
    {
        self.showDialogWithMultipleActions(message: message, title: title, alertButtonTitles:
            [
                okButtonTitle,
                "Cancel"
            ], alertButtonActions:
            [
                action,
                nil
            ],
               alertButtonStyles:
            [
                .default,
                .cancel
            ])
    }
    
    /// Show dialog in root VC with specific title and message. The dialog has two action button.
    ///
    /// - Parameters:
    ///   - message: Dialog message string.
    ///   - title: Dialog title string.
    ///   - buttonTitle1: Button title for button 1.
    ///   - action1: Completion block which will be performed when the button 1 is pressed.
    ///   - buttonTitle2: Button title for button 2.
    ///   - action2: Completion block which will be performed when the button 2 is pressed.
    open static func showDialogWithTwoActionButtons(message: String, title: String, buttonTitle1:String, action1:((UIAlertAction) -> Void)?, buttonTitle2:String, action2:((UIAlertAction) -> Void)?)
    {
        self.showDialogWithMultipleActions(message: message, title: title, alertButtonTitles:
            [
                buttonTitle1,
                buttonTitle2
            ], alertButtonActions:
            [
                action1,
                action2
            ])
    }
    
    /// Show dialog in root VC with specific title and message. The dialog has three action button.
    ///
    /// - Parameters:
    ///   - message: Dialog message string.
    ///   - title: Dialog title string.
    ///   - buttonTitle1: Button title for button 1.
    ///   - action1: Completion block which will be performed when the button 1 is pressed.
    ///   - buttonTitle2: Button title for button 2.
    ///   - action2: Completion block which will be performed when the button 2 is pressed.
    ///   - buttonTitle3: Button title for button 3.
    ///   - action3: Completion block which will be performed when the button 3 is pressed.
   open static func showDialogWithThreeActionButtons(message: String, title: String, buttonTitle1:String, action1:((UIAlertAction) -> Void)?, buttonTitle2:String, action2:((UIAlertAction) -> Void)?, buttonTitle3:String, action3:((UIAlertAction) -> Void)?)
    {
        self.showDialogWithMultipleActions(message: message, title: title, alertButtonTitles:
            [
                buttonTitle1,
                buttonTitle2,
                buttonTitle3
            ], alertButtonActions:
            [
                action1,
                action2,
                action3
            ])
    }

    /// Show dialog in root VC with specific title and message. The dialog has multiple action buttons.
    ///
    /// - Parameters:
    ///   - message: Dialog message string.
    ///   - title: Dialog title string.
    ///   - alertButtonTitles: Array with alert button titles. Default array is empty array. Default alert button title is empty string ("")
    ///   - alertButtonActions: Array with alert button actions. Default array is empty array. Default value for single action in the array is nil.
    ///   - alertButtonStyles: Array with alert button styles. Default array is empty array. Default value for UIAlertActionStyle instance in array is .default. Note: Dialog can have only one action button with .cancel style.
    open static func showDialogWithMultipleActions(message: String, title: String, alertButtonTitles:[String], alertButtonActions:[((UIAlertAction) -> Void)?], alertButtonStyles:[UIAlertActionStyle] = [])
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        for i in 0...alertButtonTitles.count-1
        {
            let buttonTitle = alertButtonTitles[i]
            let buttonAction = i < alertButtonActions.count ? alertButtonActions[i] : nil
            let buttonStyle = i < alertButtonStyles.count ? alertButtonStyles[i] : .default
            alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler:buttonAction))
        }
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true, completion: nil)
        }
    }
}
