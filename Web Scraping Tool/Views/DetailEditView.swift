//
//  DetailEditView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/21.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct DetailEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var detailViewModel: DetailViewModel
    @ObservedObject var testViewModel = TestViewModel()
    
    var scrapingPageCoreData: ScrapingPageCoreData
    
    var body: some View {
        NavigationView {
            DetailFormView(
                testViewModel: testViewModel
            )
            // MARK: init
            // EnvironmentObject can't run init so, should be in onAppear.
            .onAppear(perform: {
                detailViewModel.SetCoreData(scrapingPageCoreData)
            })
            .navigationBarItems(
                leading: Text("Update Scraping Page"),
                trailing: Button(
                    action: {
                        detailViewModel.update(
                            detailViewModel: detailViewModel,
                            scrapingPageCoreData: scrapingPageCoreData,
                            viewContext: viewContext
                        )
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Text("Save")
                        .accessibility(identifier: "detailEdit_save_button")
                }
            )
        }
    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {       
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let coreDataPreviewsModel = CoreDataPreviewsModel() // Important this class for Previews. More details -> CoreDataPreviewsModel class.
        
        DetailEditView(scrapingPageCoreData: coreDataPreviewsModel.createSampleScrapingPage(viewContext: viewContext))
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(DetailViewModel())
        
        DetailEditView(scrapingPageCoreData: coreDataPreviewsModel.createSampleScrapingPage(viewContext: viewContext))
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(DetailViewModel())
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
