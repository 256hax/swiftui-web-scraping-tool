//
//  DetailEditView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct DetailEditView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var detailViewModel = DetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var testViewModel = TestViewModel()
    
    let scrapingPageCoreData: ScrapingPageCoreData
    init(scrapingPageCoreData: ScrapingPageCoreData) {
        self.scrapingPageCoreData = scrapingPageCoreData
        self.detailViewModel.SetCoreData(self.scrapingPageCoreData)
    }
    
    var body: some View {
        NavigationView {
            DetailFormView(
                detailViewModel: detailViewModel,
                testViewModel: testViewModel)
            .navigationBarItems(
                leading: Text("Update Scraping Page"),
                trailing: Button(
                    action: {
                        testViewModel.update(
                            detailViewModel: detailViewModel,
                            scrapingPageCoreData: scrapingPageCoreData,
                            viewContext: viewContext
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
        
        let scrapingPageCoreData = ScrapingPageCoreData(context: context)
        scrapingPageCoreData.name = "Find \"Example\" words in Example.com"
        scrapingPageCoreData.url = "https://example.com/"
        scrapingPageCoreData.keyword = "Example"
        
        return DetailEditView(scrapingPageCoreData: scrapingPageCoreData).environment(\.managedObjectContext, context)
    }
}
