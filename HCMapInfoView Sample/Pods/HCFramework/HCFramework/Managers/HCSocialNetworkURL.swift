//
//  MLSocialNetwork.swift
//  Mobile Leagues
//
//  Created by Hypercube 2 on 9/27/17.
//  Copyright © 2017 Hypercube1. All rights reserved.
//

import UIKit

// Note: Add LSApplicationQueriesSchemes for every social network in in plist file
public enum HCPageType
{
    case hcUndefined
    case hcFacebookProfile
    case hcFacebookGroup
    case hcFacebookImage
    case hcFacebookEvent
    case hcFacebookMessanger
    case hcTwitterProfile
    case hcTwitterStatus
    case hcInstagramProfile
    case hcInstagramImage
    case hcYoutubeVideo
}

open class HCSocialNetworkURL: NSObject {
    
    open var id:String = ""
    open var link:String = ""
    open var urlScheme:String = ""
    open var pageType:HCPageType = .hcUndefined
    
    public init(id:String, link:String, pageType:HCPageType)
    {
        self.id = id
        self.link = link
        self.pageType = pageType
        switch pageType
        {
        case .hcFacebookProfile:
            self.urlScheme = "fb://"
        case .hcFacebookGroup:
            self.urlScheme = "fb://"
        case .hcFacebookImage:
            self.urlScheme = "fb://"
        case .hcFacebookEvent:
            self.urlScheme = "fb://"
        case .hcFacebookMessanger:
            self.urlScheme = "fb://"
        case .hcTwitterProfile:
            self.urlScheme = "twitter://"
        case .hcTwitterStatus:
            self.urlScheme = "twitter://"
        case .hcInstagramProfile:
            self.urlScheme = "instagram://"
        case .hcInstagramImage:
            self.urlScheme = "instagram://"
        case .hcYoutubeVideo:
            self.urlScheme = "youtube://"
        default:
            self.urlScheme = ""
        }
    }
    
    
    /// Tests whether it's possible to open urlScheme in Native App
    ///
    /// - Returns: It's possible to open urlScheme
    open func installedNativeApp() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: urlScheme)!)
    }
    
    /// Creates appURL based on pagetype and id
    ///
    /// - Returns: AppURL based on pagetype and id
    open func appUrl() -> String
    {
        switch pageType
        {
        case .hcFacebookProfile:
            return "fb://profile/\(id)"
        case .hcFacebookGroup:
            return "fb://group?id=\(id)"
        case .hcFacebookImage:
            return "fb://photo?id=\(id)"
        case .hcFacebookEvent:
            return "fb://event?id=\(id)"
        case .hcFacebookMessanger:
            return "fb://messaging"
        case .hcTwitterProfile:
            return "twitter://user?screen_name=\(id)"
        case .hcTwitterStatus:
            return "twitter://status?id=\(id)"
        case .hcInstagramProfile:
            return "instagram://user?username=\(id)"
        case .hcInstagramImage:
            return "instagram://media?id=\(id)"
        case .hcYoutubeVideo:
            return "youtube://\(id)"
        default:
            return ""
        }
    }
    
    /// Open link in app if it is possible, or open it in browser
    open func open()
    {
        if self.installedNativeApp()
        {
            if UIApplication.shared.canOpenURL(URL(string: self.appUrl())!)
            {
                UIApplication.shared.openURL(URL(string: self.appUrl())!)
            }
        }
        else
        {
            if UIApplication.shared.canOpenURL(URL(string: self.link)!)
            {
                UIApplication.shared.openURL(URL(string: self.link)!)
            }
        }
        
    }
    
}

