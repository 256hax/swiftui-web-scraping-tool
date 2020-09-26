//
//  ScrapingPageForm.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/26.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI
import CoreData

struct ScrapingPageForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var scrapingPageViewModel: ScrapingPageViewModel

    var body: some View {
        Form {
            Section {
                TextField("Scraping Name", text: $scrapingPageViewModel.name).autocapitalization(.none)
                TextField("Scraping Url", text: $scrapingPageViewModel.url).autocapitalization(.none)
                TextField("Search Keyword", text: $scrapingPageViewModel.keyword).autocapitalization(.none)
            }
            Section {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Scraping Test")
                }
            }
        }
    }
}
