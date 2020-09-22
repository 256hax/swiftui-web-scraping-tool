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
    @ObservedObject var scrapingPageViewModel = ScrapingPageViewModel()

    @Environment(\.presentationMode) var presentationMode
    // Call Services/Scraping
    @ObservedObject var scrapingPageService = ScrapingPageService()
    
    // Declare ScrapingPage data
//    let scrapingPageCoredataModel: ScrapingPageCoredataModel
//    init(scrapingPageCoredataModel: ScrapingPageCoredataModel) {
//        self.scrapingPageCoredataModel = scrapingPageCoredataModel
//        self.scrapingPageViewModel.name    = scrapingPageCoredataModel.name ?? "new name"
//        self.scrapingPageViewModel.url     = scrapingPageCoredataModel.url ?? ""
//        self.scrapingPageViewModel.keyword = scrapingPageCoredataModel.keyword ?? ""
//    }

    let scrapingPageCoredataModel: ScrapingPageCoredataModel
    init(scrapingPageCoredataModel: ScrapingPageCoredataModel) {
        self.scrapingPageCoredataModel = scrapingPageCoredataModel
        self.scrapingPageViewModel.SetCoredata(self.scrapingPageCoredataModel)
    }
    
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
        NavigationView {
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
                                
                                Thread.sleep(forTimeInterval: 0.5)
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
            .navigationBarItems(
                leading: Text("Update Scraping"),
                trailing: Button(
                    action: {
                        ScrapingPageCoredataModel.update(
                            in: self.viewContext,
                            scrapingPage: self.scrapingPageCoredataModel,
                            scrapingName: self.scrapingPageViewModel.name,
                            scrapingUrl: self.scrapingPageViewModel.url,
                            scrapingKeyword: self.scrapingPageViewModel.keyword
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
        
        let scrapingPageCoredataModel = ScrapingPageCoredataModel(context: context)
        scrapingPageCoredataModel.name = "Find example in Example.com"
        scrapingPageCoredataModel.url = "https://example.com/"
        scrapingPageCoredataModel.keyword = "Example"
        
        return EditScrapingView(scrapingPageCoredataModel: scrapingPageCoredataModel).environment(\.managedObjectContext, context)
    }
}
