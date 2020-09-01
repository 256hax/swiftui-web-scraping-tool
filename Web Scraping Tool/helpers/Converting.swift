//
//  ConvertingString.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/01.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

class Converting {
    /// isMatchToString
    /// - Parameter isMatch (Bool): Input result from isMatch func in NSRegex class
    /// - Returns: String instead true/false
    /// - Examples:
    func isMatchToString(_ isMatch: Bool) -> String {
        return isMatch == true ? "Matched" : "No Match"
    }
}
