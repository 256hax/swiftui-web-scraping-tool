//
//  Scraping.swift
//  Web Scraping Tool
//
//  Created by user on 2020/08/03.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

/// For Business Layer
class Scraping: ObservableObject {
    @Published var isMatch = false
    @Published var countMatches = 0
    
    /// Running Test
    /// - Parameters:
    ///   - inputUrl: Crawling URL
    ///   - pattern: Patterns for Regular Expression. ex) c(.*)t
    func test(inputUrl: String, pattern: String) {
        let encodingUrl: String = inputUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodingUrl)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let html = String(data: data, encoding: .utf8) else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.regex(inputText: html, pattern: pattern)
            }
        }
        task.resume()
    }
    
    /// Run Regular Expression
    /// - Parameters:
    ///   - inputText: String Data for Regular Expression
    ///   - pattern: Patterns for Regular Expression. ex) c(.*)t
    func regex(inputText: String, pattern: String) {
        let nsregex   = NSRegex(pattern)
        self.isMatch = nsregex.isMatch(inputText)
        self.countMatches = nsregex.countMatches(inputText)
    }
}
