//
//  UpdateScrapingView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct EditScrapingPageView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var scrapingPageViewModel = ScrapingPageViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scrapingPageService = ScrapingPageService()
    
    let scrapingPageCoredataModel: ScrapingPageCoredataModel
    init(scrapingPageCoredataModel: ScrapingPageCoredataModel) {
        self.scrapingPageCoredataModel = scrapingPageCoredataModel
        self.scrapingPageViewModel.SetCoredata(self.scrapingPageCoredataModel)
    }
    
    var body: some View {
        NavigationView {
            ScrapingPageForm(
                scrapingPageViewModel: scrapingPageViewModel,
                scrapingPageService: scrapingPageService)
            .navigationBarItems(
                leading: Text("Add Scraping"),
                trailing: Button(
                    action: {
                        scrapingPageService.update(
                            scrapingPageViewModel: scrapingPageViewModel,
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
        
        return EditScrapingPageView(scrapingPageCoredataModel: scrapingPageCoredataModel).environment(\.managedObjectContext, context)
    }
}
