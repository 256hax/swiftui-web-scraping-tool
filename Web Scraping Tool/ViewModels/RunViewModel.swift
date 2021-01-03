//
//  RunViewModel.swift
//  Web Scraping Tool
//
//  Created by user on 2020/10/15.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class RunViewModel: ObservableObject {
    @Published var isMatch = false
    @Published var isScraping = false
    @Published var runningTestResult = ""
    @Published var isRunning: Bool = false

    var timer = Timer()
    // Next Scraping Count Down Timer (sec).
    let defaultCountdownTimer = 300.0
    // Time Interval (sec).
    let timeInterval = 0.1
    // Reset Timing. Shouldn't use "0.0". It start minus count down (ex: -0.1) issue.
    let resetCountdownTimerLimit = 0.1
    // Double is better for count down.
    @Published var countdownTimer: Double
    
    init() {
        self.countdownTimer = self.defaultCountdownTimer
    }
 
    func startScraping(scrapingPageCoreData: FetchedResults<ScrapingPageCoreData>) {
        timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true) { timer in
            self.countdownTimer -= self.timeInterval
            
            if(self.countdownTimer < self.resetCountdownTimerLimit) {
                self.countdownTimer = self.defaultCountdownTimer
                                
                for s in scrapingPageCoreData {
                    self.scrapingTask(inputUrl: s.url!, pattern: s.keyword!, name: s.name!)
                }
            }
        }
    }
    
    func stopScraping() {
        timer.invalidate()
        self.countdownTimer = self.defaultCountdownTimer
    }
    
    /// Run Scraping
    /// - Parameters:
    ///   - inputUrl: Crawling URL
    ///   - pattern: Patterns for Regular Expression. ex) c(.*)t
    func scrapingTask(inputUrl: String, pattern: String, name: String) {
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
                    self.runningTestResult = "\(name): Unable to access Website. Check URL."
                    
                    return
                }

                // [Success case]
                guard let html = String(data: data, encoding: .utf8) else { return }

                self.regex(inputText: html, pattern: pattern, name: name)
                
                let nsregex = NSRegex(pattern)
                if(nsregex.isMatch(html)) {
                    self.postNotification(title: name, body: self.runningTestResult)
                }
                
                // End ProgressView
                self.isScraping = false
            }
        }
        task.resume()
        // "URLSession.shared.dataTask" can't get return. Should write all code in there.
    }
    
    /// Run Regular Expression
    /// - Parameters:
    ///   - inputText: String Data for Regular Expression
    ///   - pattern: Patterns for Regular Expression. ex) c(.*)t
    func regex(inputText: String, pattern: String, name: String) {
        let nsregex = NSRegex(pattern)
        let converting = Converting()
        let convertedIsMatch = converting.isMatchToString(nsregex.isMatch(inputText))
        let convertedCountMatches = converting.numberToCount(nsregex.countMatches(inputText))

        // Result is used on some screen.
        self.runningTestResult = "\(name): \(convertedIsMatch) \(convertedCountMatches)"
    }
    
    func postNotification(title: String, body: String) {
       let content = UNMutableNotificationContent()
       content.title = "Hit!"
       content.body = body
    
       let id = "reminder-\(UUID())"
       let request = UNNotificationRequest(identifier: id, content: content, trigger: nil)
    
       let center = UNUserNotificationCenter.current()
       center.add(request, withCompletionHandler: nil)
    }
}
