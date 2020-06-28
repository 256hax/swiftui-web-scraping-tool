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
    @Published var name = ""
    @Published var url = ""
}

struct UpdateScrapingView: View {
    @Environment(\.managedObjectContext) var viewContext
    // Observe for user input
    @ObservedObject var updateUserInput = UpdateUserInput()
    @Environment(\.presentationMode) var presentationMode

    // Declare ScrapingPage data
    let scrapingPage: ScrapingPage
    init(scrapingPage: ScrapingPage) {
        self.scrapingPage = scrapingPage
        self.updateUserInput.name = scrapingPage.name ?? "new name"
        self.updateUserInput.url = scrapingPage.url ?? ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Scraping Name", text: $updateUserInput.name)
                    TextField("Scraping Url", text: $updateUserInput.url)
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
                            scrapingUrl: self.updateUserInput.url
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
        scrapingPage.name = "find example in Example.com"
        scrapingPage.url = "https://example.com/"
        
        return UpdateScrapingView(scrapingPage: scrapingPage).environment(\.managedObjectContext, context)
    }
}
