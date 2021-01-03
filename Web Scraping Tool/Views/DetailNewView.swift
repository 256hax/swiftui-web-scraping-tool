//
//  DetailNewView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/07/05.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct DetailNewView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var detailViewModel = DetailViewModel()
    @ObservedObject var scrapingPageDetailService = TestViewModel()
    
    var body: some View {
        NavigationView {
            DetailFormView(
                detailViewModel: detailViewModel,
                scrapingPageDetailService: scrapingPageDetailService)
            .navigationBarItems(
                leading: Text("Add Scraping Page"),
                trailing: Button(
                    action: {
                        scrapingPageDetailService.create(detailViewModel: detailViewModel, viewContext: viewContext)
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
        DetailNewView()
    }
}
