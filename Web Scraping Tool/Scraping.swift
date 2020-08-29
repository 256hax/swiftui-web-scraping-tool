//
//  Scraping.swift
//  Web Scraping Tool
//
//  Created by user on 2020/08/03.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

class Scraping {
    func test(inputUrl: String, pattern: String) {
        let encodingUrl: String = inputUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodingUrl)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let html = String(data: data, encoding: .utf8) else { return }
            
            self.regex(inputText: html, pattern: pattern)
        }

        task.resume()
    }
    
    func regex(inputText: String, pattern: String) {
        let nsregex   = NSRegex(pattern)
        print( nsregex.countMatches(inputText) )
    }
}

//let url = "https://example.com/"
//let pattern   = "example"
//let scraping = Scraping()
//scraping.test(inputUrl: url, pattern: pattern)
