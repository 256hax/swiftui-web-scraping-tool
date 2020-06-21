//
//  UpdateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI
import CoreData

class UpdateData: ObservableObject {
    @Published var name = ""
    @Published var url = ""
}

struct UpdateScrapingView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var updateData = UpdateData()
    
    let scrapingPage: ScrapingPage
    init(scrapingPage: ScrapingPage) {
        self.scrapingPage = scrapingPage
        self.updateData.name = scrapingPage.name ?? "new name"
        self.updateData.url = scrapingPage.url ?? ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Scraping Name", text: $updateData.name)
                    TextField("Scraping Url", text: $updateData.url)
                }
            }
            .navigationBarItems(
                leading: Text("Add Scraping"),
                trailing: Button(
                    action: {
                        ScrapingPage.create(
                            in: self.viewContext,
                            scrapingName: self.updateData.name,
                            scrapingUrl: self.updateData.url
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
