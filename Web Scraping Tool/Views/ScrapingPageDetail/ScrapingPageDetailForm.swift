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
    @ObservedObject var detailViewModel: DetailViewModel
    @ObservedObject var scrapingPageDetailService: TestViewModel

    var runningTestResultText: String {
        return scrapingPageDetailService.runningTestResult
    }

    var body: some View {
        Form {
            // Settings
            Section(footer: Text("Search Keyword supports Regular Expression")) {
                TextField("Scraping Name", text: $detailViewModel.name).autocapitalization(.none)
                TextField("Scraping URL", text: $detailViewModel.url).autocapitalization(.none)
                TextField("Search Keyword", text: $detailViewModel.keyword).autocapitalization(.none)
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
                                inputUrl: detailViewModel.url,
                                pattern: detailViewModel.keyword
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
        if(detailViewModel.url.count > 0) {
            WebView(loadUrl: detailViewModel.url)
        }
    }
}

struct ScrapingPageForm_Previews: PreviewProvider {
    static var previews: some View {
        NewScrapingPageDetailView()
    }
}
