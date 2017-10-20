//
//  HCDate.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

// MARK: - Date extension
extension Date
{
    /// Create the date object from string with formatting which is passed in stingFormat.
    ///
    /// - Parameters:
    ///   - strDate: This is the string that contains date value.
    ///   - stringFormat: format used in the string to store the date. Default value "yyyy-MM-dd HH:mm:ss".
    /// - Returns: format used in the string to store the date. Default value "yyyy-MM-dd HH:mm:ss".
    static public func hcDateFromString(_ strDate: String?, stringFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date?
    {
        if strDate == nil || strDate! == ""
        {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringFormat
        let returnDate = dateFormatter.date(from: strDate!)
        
        return returnDate
    }
    
    /// Create the string from date object with formatting which is passed in stingFormat.
    ///
    /// - Parameters:
    ///   - date: The date that contains date value.
    ///   - stringFormat: Format used for the string to store the date. Default value "yyyy-MM-dd HH:mm:ss".
    /// - Returns: String value of that date object.
    static public func hcStringFromDate(_ date: Date, stringFormat: String = "yyyy-MM-dd HH:mm:ss") -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringFormat
        return dateFormatter.string(from: date)
    }
    
    /// Convert one string data with one formatting to some other string with different formatting.
    ///
    /// - Parameters:
    ///   - strDate: Date that contains input string date.
    ///   - inStringFormat: Format used for input string to store the date. Default value "yyyy-MM-dd HH:mm:ss".
    ///   - outStringFormat: Format used for output sting to store the date. Default value "yyyy-MM-dd HH:mm:ss".
    /// - Returns: String value of that date formated like in outStringFormat.
    static public func hcStringFromStringDate(_ strDate: String,
                                     inStringFormat: String = "yyyy-MM-dd HH:mm:ss",
                                     outStringFormat: String = "yyyy-MM-dd HH:mm:ss") -> String
    {
        if strDate == ""
        {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inStringFormat
        let returnDate = dateFormatter.date(from: strDate)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = outStringFormat
        return dateFormatter2.string(from: returnDate!)
    }
}
