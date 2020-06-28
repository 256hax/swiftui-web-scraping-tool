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
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var updateUserInput = UpdateUserInput()
    
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
//                        ScrapingPage.create(
//                            in: self.viewContext,
//                            scrapingName: self.updateUserInput.name,
//                            scrapingUrl: self.updateUserInput.url
//                        )
                        self.scrapingPage.name = self.updateUserInput.name
                        self.scrapingPage.url = self.updateUserInput.url
                        self.presentationMode.wrappedValue.dismiss()
                        
                        do {
                            try  self.viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nserror = error as NSError
                            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                        }
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
