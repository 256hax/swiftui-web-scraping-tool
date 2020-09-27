//
//  ScrapingPageForm.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/26.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct ScrapingPageForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var scrapingPageViewModel: ScrapingPageViewModel
    @ObservedObject var scrapingPageService: ScrapingPageService

    let converting = Converting()
    
    var runningTestResult: String {
        // [todo]
        // Case1: Default text
        // Case2: Run scraping
        // Case3: Completion result
        let text = "\(self.converting.isMatchToString(self.scrapingPageService.isMatch)) \(self.converting.countWithTimes(self.scrapingPageService.countMatches))"
        return text
    }

    var body: some View {
        Form {
            Section {
                TextField("Scraping Name", text: $scrapingPageViewModel.name).autocapitalization(.none)
                TextField("Scraping Url", text: $scrapingPageViewModel.url).autocapitalization(.none)
                TextField("Search Keyword", text: $scrapingPageViewModel.keyword).autocapitalization(.none)
            }
            Section {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            // [todo] delete sample value
                            let url = "https://example.com/"
                            let pattern   = "example"
                            
                            Thread.sleep(forTimeInterval: 0.2)
                            self.scrapingPageService.test(inputUrl: url, pattern: pattern)
                        }
                    ) {
                        Text("Running Test")
                    }
                }
                HStack {
                    Spacer()
                    Text(runningTestResult)
                }
            }
        }
    }
}

struct ScrapingPageForm_Previews: PreviewProvider {
    static var previews: some View {
        NewScrapingPageView()
    }
}
