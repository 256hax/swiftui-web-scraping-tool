//
//  ScrapingPageForm.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/26.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct ScrapingPageDetailForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var scrapingPageDetailViewModel: ScrapingPageDetailViewModel
    @ObservedObject var scrapingPageDetailService: ScrapingPageDetailService

    var runningTestResultText: String {
        return scrapingPageDetailService.runningTestResult
    }

    var body: some View {
        Form {
            // Settings
            Section(footer: Text("Search Keyword supports Regular Expression")) {
                TextField("Scraping Name", text: $scrapingPageDetailViewModel.name).autocapitalization(.none)
                TextField("Scraping URL", text: $scrapingPageDetailViewModel.url).autocapitalization(.none)
                TextField("Search Keyword", text: $scrapingPageDetailViewModel.keyword).autocapitalization(.none)
            }
            // Running Test
            Section {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            // Prevent double submission
                            Thread.sleep(forTimeInterval: 0.1)
                            
                            scrapingPageDetailService.test(
                                inputUrl: scrapingPageDetailViewModel.url,
                                pattern: scrapingPageDetailViewModel.keyword
                            )
                        }
                    ) {
                        Text("Running Test")
                    }
                }
                HStack {
                    Spacer()
                    if(scrapingPageDetailService.isScraping) {
                        ProgressView("Scraping...")
                    } else {
                        Text(runningTestResultText)
                    }
                }
            }
        }
        // Scraping URL Preview
        if(scrapingPageDetailViewModel.url.count > 0) {
            WebView(loadUrl: scrapingPageDetailViewModel.url)
        }
    }
}

struct ScrapingPageForm_Previews: PreviewProvider {
    static var previews: some View {
        NewScrapingPageDetailView()
    }
}
