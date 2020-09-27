//
//  CreateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/07/05.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct NewScrapingPageView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scrapingPageViewModel = ScrapingPageViewModel()
    @ObservedObject var scrapingPageService = ScrapingPageService()
    
    var body: some View {
        NavigationView {
            ScrapingPageForm(
                scrapingPageViewModel: scrapingPageViewModel,
                scrapingPageService: scrapingPageService)
            .navigationBarItems(
                leading: Text("Add Scraping"),
                trailing: Button(
                    action: {
                        scrapingPageService.create(scrapingPageViewModel: scrapingPageViewModel, viewContext: viewContext)
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
        NewScrapingPageView()
    }
}
