//
//  Scraping.swift
//  Web Scraping Tool
//
//  Created by user on 2020/08/03.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation
import CoreData

// For Business Layer
class ScrapingPageService: ObservableObject {
    @Published var isMatch = false
    @Published var countMatches = 0
    @Published var isScraping = false
    
    /// Running Test
    /// - Parameters:
    ///   - inputUrl: Crawling URL
    ///   - pattern: Patterns for Regular Expression. ex) c(.*)t
    func test(inputUrl: String, pattern: String) {
        let encodingUrl: String = inputUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodingUrl)!
        
        // Start ProgressView
        self.isScraping = true

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let html = String(data: data, encoding: .utf8) else { return }
            
            // Prevent double submission and feel scraping
            let delayTime = DispatchTime.now() + Double.random(in: 0.1...2)
            
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.regex(inputText: html, pattern: pattern)
                // End ProgressView
                self.isScraping = false
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
    
    func create(scrapingPageViewModel: ScrapingPageViewModel, viewContext: NSManagedObjectContext) {
        ScrapingPageCoredataModel.create(
            in: viewContext,
            scrapingName: scrapingPageViewModel.name,
            scrapingUrl: scrapingPageViewModel.url,
            scrapingKeyword: scrapingPageViewModel.keyword
        )
    }
    
    func update(scrapingPageViewModel: ScrapingPageViewModel, scrapingPageCoredataModel: ScrapingPageCoredataModel, viewContext: NSManagedObjectContext) {
        ScrapingPageCoredataModel.update(
            in: viewContext,
            scrapingPageCoredataModel: scrapingPageCoredataModel,
            scrapingName: scrapingPageViewModel.name,
            scrapingUrl: scrapingPageViewModel.url,
            scrapingKeyword: scrapingPageViewModel.keyword
        )
    }
}
