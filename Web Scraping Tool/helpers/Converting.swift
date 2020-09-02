//
//  ConvertingString.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/01.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

class Converting {
    /// isMatch To String
    /// - Parameter isMatch: Input result from isMatch func in NSRegex class
    /// - Returns: String instead true/false
    func isMatchToString(_ isMatch: Bool) -> String {
        return isMatch == true ? "Matched" : "No Match"
    }
    
    /// Count With Times
    /// - Parameter count: Count number. ex) Matched number in Regular Expression
    /// - Returns: Count with times. Return empty string if no counting.
    func countWithTimes(_ count: Int) -> String {
        switch count {
        case 0:
            return ""
        case 1:
            return "once"
        case 2:
            return "twice"
        default:
            return "\(count) times"
        }
    }
}
