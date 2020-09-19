//
//  UpdateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI
import CoreData

struct EditScrapingView: View {
    @Environment(\.managedObjectContext) var viewContext
    // Observe for user input
    @ObservedObject var updateUserInput = UpdateUserInput()
//    @EnvironmentObject var updateUserInput: UpdateUserInput

    @Environment(\.presentationMode) var presentationMode
    // Call Services/Scraping
    @ObservedObject var scraping = Scraping()
    
    // Declare ScrapingPage data
    let scrapingPage: ScrapingPageCoredataModel
    init(scrapingPage: ScrapingPageCoredataModel) {
        self.scrapingPage = scrapingPage
        self.updateUserInput.name    = scrapingPage.name ?? "new name"
        self.updateUserInput.url     = scrapingPage.url ?? ""
        self.updateUserInput.keyword = scrapingPage.keyword ?? ""
    }
    
    let converting = Converting()
    
    var runningTestResult: String {
        // [todo]
        // Case1: Default text
        // Case2: Run scraping
        // Case3: Completion result
        let text = "\(self.converting.isMatchToString(self.scraping.isMatch)) \(self.converting.countWithTimes(self.scraping.countMatches))"
        return text
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Scraping Name", text: $updateUserInput.name).autocapitalization(.none)
                    TextField("Scraping Url", text: $updateUserInput.url).autocapitalization(.none)
                    TextField("Search Keyword", text: $updateUserInput.keyword).autocapitalization(.none)
                }
                Section {
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                // [todo] delete sample value
                                let url = "https://example.com/"
                                let pattern   = "example"
                                
                                Thread.sleep(forTimeInterval: 0.5)
                                self.scraping.test(inputUrl: url, pattern: pattern)
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
            .navigationBarItems(
                leading: Text("Update Scraping"),
                trailing: Button(
                    action: {
                        ScrapingPageCoredataModel.update(
                            in: self.viewContext,
                            scrapingPage: self.scrapingPage,
                            scrapingName: self.updateUserInput.name,
                            scrapingUrl: self.updateUserInput.url,
                            scrapingKeyword: self.updateUserInput.keyword
                        )
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Text("Save")
                }
            )
        }
    }
}


struct UpdateScrapingView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let scrapingPage = ScrapingPageCoredataModel(context: context)
        scrapingPage.name = "Find example in Example.com"
        scrapingPage.url = "https://example.com/"
        scrapingPage.keyword = "Example"
        
        return EditScrapingView(scrapingPage: scrapingPage).environment(\.managedObjectContext, context)
    }
}
