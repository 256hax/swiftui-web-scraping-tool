//
//  NSRegex.swift
//  Web Scraping Tool
//
//  Created by user on 2020/08/16.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

/// Regular Expression Utility
/// - Parameter pattern: Pattern of Regular Expression
/// - Returns: none
/// - Examples:
///```
///let pattern = "dog|cat"
///let nsregex = NSRegex(pattern)
///```
class NSRegex {
    let expression: NSRegularExpression

    init(_ pattern: String) {
        do {
            self.expression = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            print("Failed to getting of pattern: \(pattern)")
            self.expression = try! NSRegularExpression(pattern: "!.*", options: [])
        }
    }
    
    /// Count Matches
    /// - Parameter inputText: Input Text to Regular Expression
    /// - Returns: Number of matches
    /// - Examples:
    ///```
    ///let pattern   = "dog|cat"
    ///let inputText = "dog bird cat"
    ///let nsregex   = NSRegex(pattern)
    ///print( nsregex.countMatches(inputText) ) // => 2
    ///```
    func countMatches(_ inputText: String) -> Int {
        let matches = self.expression.matches(in: inputText, options: [], range: NSRange(0..<inputText.count))
        return matches.count
    }

    /// Is Match?
    /// - Parameter inputText: Input Text to Regular Expression
    /// - Returns: Number of matches
    /// - Examples:
    ///```
    ///let pattern   = "dog|cat"
    ///let inputText = "dog bird cat"
    ///let nsregex   = NSRegex(pattern)
    ///print( nsregex.isMatch(inputText) ) // => true
    ///```
    func isMatch(_ inputText: String) -> Bool {
        let matches = self.expression.matches(in: inputText, options: [], range: NSRange(0..<inputText.count))
        return matches.count > 0
    }
}
