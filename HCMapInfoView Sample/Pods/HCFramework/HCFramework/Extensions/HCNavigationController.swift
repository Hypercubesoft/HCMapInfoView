//
//  HCNavigationController.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

// MARK: - UINavigationController extension
extension UINavigationController
{
    /// A wrapper method for popViewController, which is used to open previous page in navigation stack.
    ///
    /// - Parameter animated: Defines if transition to previous page is animated. Default value is true.
    open func hcGoBack(animated:Bool = true)
    {
        let viewControllers = self.viewControllers
        
        let num = viewControllers.count
        
        if num < 2
        {
            // This is last VC. Can't use pop.
            return
        }
        
        popViewController(animated: animated)
    }
    
    /// A wrapper method for popToRootViewController, which is used to open root page (view controller) in navigation stack.
    ///
    /// - Parameter animated: Defines if transition to root page (view controller) is animated. Default value is true.
    open func hcPopToRootVC(animated:Bool = true)
    {
        self.popToRootViewController(animated: animated)
    }
    
    /// A method for opening defined page (view controller) which enables user to define additional parameters for opening that page.
    ///
    /// - Parameters:
    ///   - vc: UIViewController instance, i.e. page which has to be presented.
    ///   - animated: Defines if transition to provided page (view controller) is animated. Default value is true.
    ///   - clearAll: Defines if navigation stack has to be cleared leaving only current top view controller in navigation stack. Default value is false.
    ///   - popToVCIfExists: Defines if navigation controller has to pop to defined view controller (if a view controller with same restorationIdentifier is already in navigation stack) instead of pushing that view controller. Default value is false.
    ///   - allowSameVC: Defines if it is allowed to open a view controller if a view controller wish same restorationIdentifier is already on the top of the navigation stack. Default value is false.
    open func hcOpenVC(_ vc:UIViewController, animated:Bool = true, clearAll:Bool = false, popToVCIfExists:Bool = false, allowSameVC:Bool = false)
    {
        if !allowSameVC && self.viewControllers.count > 0 && self.viewControllers.last?.restorationIdentifier == vc.restorationIdentifier!
        {
            // This is VC is allready on top.
            return
        }
        
        if popToVCIfExists
        {
            let viewControllers = self.viewControllers
            for viewController in viewControllers
            {
                if viewController.restorationIdentifier == vc.restorationIdentifier!
                {
                    // Did find restorationIdentifier. Will perform pop to it.
                    self.popToViewController(viewController, animated: true)
                    return
                }
            }
        }
        
        if clearAll
        {
            let lastvc = self.viewControllers.last
            
            self.viewControllers.removeAll()
            self.viewControllers.append(lastvc!)
        }
        
        pushViewController(vc, animated: animated)
    }
    
    /// A method for opening a page (view controller) defined with given identifier and storyboard name which enables user to define additional parameters for opening that page.
    ///
    /// - Parameters:
    ///   - identifier: Restoration identifier for view controller which has to be presented.
    ///   - storyBoardName: Storyboard name from which we get a view controller with a given (restoration) identifier to be presented. Default value is "Main".
    ///   - animated: Defines if transition to provided page (view controller) is animated. Default value is true.
    ///   - clearAll: Defines if navigation stack has to be cleared leaving only current top view controller in navigation stack. Default value is false.
    ///   - popToVCIfExists: efines if navigation controller has to pop to defined view controller (if a view controller with same restorationIdentifier is already in navigation stack) instead of pushing that view controller. Default value is false.
    ///   - allowSameVC: Defines if it is allowed to open a view controller if a view controller wish same restorationIdentifier is already on the top of the navigation stack. Default value is false.
    open func hcOpenVC(_ identifier:String, storyBoardName:String = "Main", animated:Bool = true, clearAll:Bool = false, popToVCIfExists:Bool = false, allowSameVC:Bool = false)
    {
        hcOpenVC(hcGetVCForIdentifier(identifier, storyBoardName: storyBoardName), animated:animated, clearAll:clearAll, popToVCIfExists:popToVCIfExists, allowSameVC:allowSameVC)
    }
    
    /// Generating instace of a view controller based on a provided (restoration) identifier and storyboard name.
    ///
    /// - Parameters:
    ///   - identifier: Restoration identifier for view controller which has to be presented.
    ///   - storyBoardName: Storyboard name from which we get a view controller with a given (restoration) identifier to be presented. Default value is "Main".
    /// - Returns: UIViewController instance initialized using given storyboard name and (restoration) identifier.
    open func hcGetVCForIdentifier(_ identifier:String, storyBoardName:String = "Main") -> UIViewController
    {
        let storyboard = UIStoryboard(name:storyBoardName, bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        viewController.restorationIdentifier = identifier
        return viewController
    }
    
    /// Helper method which is used for getting top view controller in application. Top view controller is used for accessing navigation controller for hcGetNC() method
    ///
    /// - Parameter controller: Provided UIViewController instance for which we are searching for top view controller.
    /// - Returns: Top UIViewController instance
    static open func hcTopVC(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return hcTopVC(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return hcTopVC(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return hcTopVC(controller: presented)
        }
        return controller
    }
    
    /// Find and return navigation controller which can be used for navigation in application.
    ///
    /// - Returns: UINavigationController instance, i.e. navigation controller which should be used for other methods in this extension.
    static open func hcGetNC() -> UINavigationController
    {
        return self.hcTopVC()!.navigationController!
    }
}
