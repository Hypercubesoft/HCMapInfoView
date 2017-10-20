//
//  HCArray.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import Foundation

// MARK: Array extension
extension Array
{
    /// Shuffles array elements.
    mutating public func hcShuffle ()
    {
        for i in (0..<self.count).reversed()
        {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
    
    /// Creates a copy of existing array, shuffles it and returns that shuffled array with first n elements.
    ///
    /// - Parameter n: The number of elements of the resulting shuffled array
    /// - Returns: Shuffled array with n elements. If n is greater than the number of elements of the original array, the array will contain the number of elements of the original array.
    public func hcShuffleAndSlice(numberOfElements n: Int) -> Array
    {
        var array = Array()
        array.append(contentsOf: self)
        array.hcShuffle()
        array = Array(array.prefix(Swift.min(self.count,n)))
        return array
    }
}
