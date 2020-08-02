//
//  CreateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/07/05.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct NewScrapingView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State var scrapingName = ""
    @State var scrapingUrl = ""
    @State var scrapingKeyword = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Scraping Name", text: $scrapingName)
                    TextField("Scraping Url", text: $scrapingUrl)
                    TextField("Search Keyword", text: $scrapingKeyword)
                }
                Section {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Scraping Test")
                    }
                }
            }
            .navigationBarItems(
                leading: Text("Add Scraping"),
                trailing: Button(
                    action: {
                        ScrapingPage.create(
                            in: self.viewContext,
                            scrapingName: self.scrapingName,
                            scrapingUrl: self.scrapingUrl,
                            scrapingKeyword: self.scrapingKeyword
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

struct CreateScrapingView_Previews: PreviewProvider {
    static var previews: some View {
        NewScrapingView()
    }
}
