//
//  DetailFormView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/26.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct DetailFormView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var detailViewModel: DetailViewModel
    @ObservedObject var testViewModel: TestViewModel
    // Prevent conflict Binding in SwiftUI (in this case, realtime converting encoding/decoding URL).
    @State var editing = false

    var runningResultText: String {
        return testViewModel.runningResult
    }

    var body: some View {
        VStack {
            Form {
                // MARK: Settings
                Section(footer: Text("Search Keyword supports Regular Expression")) {
                    TextField("Scraping Name", text: $detailViewModel.name).autocapitalization(.none)
                    TextField(
                        "Scraping URL",
                        text: $detailViewModel.url,
                        // Editing or OnFocus
                        onEditingChanged: { changed in
                            if(changed) {
                                self.editing = true
                            } else {
                                self.editing = false
                            }
                        },
                        // Pressed Enter in Keyboard
                        onCommit: {
                            self.editing = false
                        }
                    ).autocapitalization(.none)
                    TextField("Search Keyword", text: $detailViewModel.keyword).autocapitalization(.none)
                }
                // MARK: Running Test
                Section {
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                // Prevent double submission
                                Thread.sleep(forTimeInterval: 0.1)
                                
                                testViewModel.test(
                                    inputUrl: detailViewModel.url,
                                    pattern: detailViewModel.keyword
                                )
                            }
                        ) {
                            Text("Running Test")
                                .accessibility(identifier: "detailForm_runTest_button")
                        }
                    }
                    HStack {
                        Spacer()
                        if(testViewModel.isScraping) {
                            ProgressView("Scraping...")
                        } else {
                            Text(runningResultText)
                        }
                    }
                }
            }
            // MARK: Scraping URL Preview
            // Count 12 means URL need at least 12 charactors(ex: https://a.co).
            if(detailViewModel.url.count >= 12 && self.editing == false) {
                WebView(loadUrl: detailViewModel.url)
            }
        }
    }
}

struct ScrapingPageForm_Previews: PreviewProvider {
    static var previews: some View {
        DetailFormView(testViewModel: TestViewModel())
    }
}
