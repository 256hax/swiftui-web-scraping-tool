//
//  UpdateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct EditScrapingPageDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var scrapingPageDetailViewModel = ScrapingPageDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scrapingPageDetailService = TestViewModel()
    
    let scrapingPageCoredataModel: ScrapingPageCoredataModel
    init(scrapingPageCoredataModel: ScrapingPageCoredataModel) {
        self.scrapingPageCoredataModel = scrapingPageCoredataModel
        self.scrapingPageDetailViewModel.SetCoredata(self.scrapingPageCoredataModel)
    }
    
    var body: some View {
        NavigationView {
            ScrapingPageDetailForm(
                scrapingPageDetailViewModel: scrapingPageDetailViewModel,
                scrapingPageDetailService: scrapingPageDetailService)
            .navigationBarItems(
                leading: Text("Update Scraping Page"),
                trailing: Button(
                    action: {
                        scrapingPageDetailService.update(
                            scrapingPageDetailViewModel: scrapingPageDetailViewModel,
                            scrapingPageCoredataModel: scrapingPageCoredataModel,
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
        
        let scrapingPageCoredataModel = ScrapingPageCoredataModel(context: context)
        scrapingPageCoredataModel.name = "Find \"Example\" words in Example.com"
        scrapingPageCoredataModel.url = "https://example.com/"
        scrapingPageCoredataModel.keyword = "Example"
        
        return EditScrapingPageDetailView(scrapingPageCoredataModel: scrapingPageCoredataModel).environment(\.managedObjectContext, context)
    }
}
