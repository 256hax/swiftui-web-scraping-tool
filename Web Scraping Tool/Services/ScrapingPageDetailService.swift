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
class ScrapingPageDetailService: ObservableObject {
    @Published var isMatch = false
    @Published var isScraping = false
    @Published var runningTestResult = "-"
    
    /// Running Test
    /// - Parameters:
    ///   - inputUrl: Crawling URL
    ///   - pattern: Patterns for Regular Expression. ex) c(.*)t
    func test(inputUrl: String, pattern: String) {
        // Exit if input is empty
        if(inputUrl.count == 0 || pattern.count == 0) {
            return
        }

        // Start ProgressView
        self.isScraping = true

        let encodingUrl: String = inputUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodingUrl)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Prevent double submission and feel scraping
            let delayTime = DispatchTime.now() + Double.random(in: 0.1...2)
            
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                guard let data = data else {
                    // [Error case]
                    // End ProgressView
                    self.isScraping = false
                    self.runningTestResult = "Unable to access Website. Check URL."
                    
                    return
                }

                // [Success case]
                guard let html = String(data: data, encoding: .utf8) else { return }

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
        let nsregex = NSRegex(pattern)
        let converting = Converting()
        let convertedIsMatch = converting.isMatchToString(nsregex.isMatch(inputText))
        let convertedCountMatches = converting.countWithTimes(nsregex.countMatches(inputText))

        self.runningTestResult = "\(convertedIsMatch) \(convertedCountMatches)"
    }
    
    func create(scrapingPageDetailViewModel: ScrapingPageDetailViewModel, viewContext: NSManagedObjectContext) {
        ScrapingPageCoredataModel.create(
            in: viewContext,
            scrapingName: scrapingPageDetailViewModel.name,
            scrapingUrl: scrapingPageDetailViewModel.url,
            scrapingKeyword: scrapingPageDetailViewModel.keyword
        )
    }
    
    func update(scrapingPageDetailViewModel: ScrapingPageDetailViewModel, scrapingPageCoredataModel: ScrapingPageCoredataModel, viewContext: NSManagedObjectContext) {
        ScrapingPageCoredataModel.update(
            in: viewContext,
            scrapingPageCoredataModel: scrapingPageCoredataModel,
            scrapingName: scrapingPageDetailViewModel.name,
            scrapingUrl: scrapingPageDetailViewModel.url,
            scrapingKeyword: scrapingPageDetailViewModel.keyword
        )
    }
}