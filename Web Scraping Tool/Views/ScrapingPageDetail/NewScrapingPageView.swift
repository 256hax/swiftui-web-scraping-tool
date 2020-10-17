//
//  CreateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/07/05.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct NewScrapingPageDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scrapingPageDetailViewModel = ScrapingPageDetailViewModel()
    @ObservedObject var scrapingPageDetailService = ScrapingPageDetailService()
    
    var body: some View {
        NavigationView {
            ScrapingPageForm(
                scrapingPageDetailViewModel: scrapingPageDetailViewModel,
                scrapingPageDetailService: scrapingPageDetailService)
            .navigationBarItems(
                leading: Text("Add Scraping Page"),
                trailing: Button(
                    action: {
                        scrapingPageDetailService.create(scrapingPageDetailViewModel: scrapingPageDetailViewModel, viewContext: viewContext)
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
        NewScrapingPageDetailView()
    }
}
