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

    var runningTestResultText: String {
        return scrapingPageService.runningTestResult
    }

    var body: some View {
        Form {
            // Settings
            Section(footer: Text("Search Keyword supports Regular Expression")) {
                TextField("Scraping Name", text: $scrapingPageViewModel.name).autocapitalization(.none)
                TextField("Scraping URL", text: $scrapingPageViewModel.url).autocapitalization(.none)
                TextField("Search Keyword", text: $scrapingPageViewModel.keyword).autocapitalization(.none)
            }
            // Running Test
            Section {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            // Prevent double submission
                            Thread.sleep(forTimeInterval: 0.1)
                            
                            self.scrapingPageService.test(inputUrl: scrapingPageViewModel.url, pattern: scrapingPageViewModel.keyword)
                        }
                    ) {
                        Text("Running Test")
                    }
                }
                HStack {
                    Spacer()
                    if(scrapingPageService.isScraping) {
                        ProgressView("Scraping...")
                    } else {
                        Text(runningTestResultText)
                    }
                }
            }
        }
        // Scraping URL Preview
        if(scrapingPageViewModel.url.count > 0) {
            WebView(loadUrl: scrapingPageViewModel.url)
        }
    }
}

struct ScrapingPageForm_Previews: PreviewProvider {
    static var previews: some View {
        NewScrapingPageView()
    }
}
