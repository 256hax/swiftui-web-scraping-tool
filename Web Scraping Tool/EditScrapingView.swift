//
//  UpdateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI
import CoreData

class UpdateUserInput: ObservableObject {
    @Published var name    = ""
    @Published var url     = ""
    @Published var keyword = ""
}

struct EditScrapingView: View {
    @Environment(\.managedObjectContext) var viewContext
    // Observe for user input
    @ObservedObject var updateUserInput = UpdateUserInput()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scraping = Scraping()
    
    // Declare ScrapingPage data
    let scrapingPage: ScrapingPage
    init(scrapingPage: ScrapingPage) {
        self.scrapingPage = scrapingPage
        self.updateUserInput.name    = scrapingPage.name ?? "new name"
        self.updateUserInput.url     = scrapingPage.url ?? ""
        self.updateUserInput.keyword = scrapingPage.keyword ?? ""
    }
    
    let converting = Converting()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Scraping Name", text: $updateUserInput.name)
                    TextField("Scraping Url", text: $updateUserInput.url)
                    TextField("Search Keyword", text: $updateUserInput.keyword)
                }
                Section {
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                let url = "https://example.com/"
                                let pattern   = "example"
                                self.scraping.test(inputUrl: url, pattern: pattern)
                            }
                        ) {
                            Text("Running Test")
                        }
                    }
                    HStack {
                        Spacer()
                        Text("\(self.converting.isMatchToString(self.scraping.isMatch))")
                            .foregroundColor(Color.gray)
                        Text("\(self.converting.countWithTimes(self.scraping.countMatches))")
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .navigationBarItems(
                leading: Text("Update Scraping"),
                trailing: Button(
                    action: {
                        ScrapingPage.update(
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
        
        let scrapingPage = ScrapingPage(context: context)
        scrapingPage.name = "Find example in Example.com"
        scrapingPage.url = "https://example.com/"
        scrapingPage.keyword = "Example"
        
        return EditScrapingView(scrapingPage: scrapingPage).environment(\.managedObjectContext, context)
    }
}
