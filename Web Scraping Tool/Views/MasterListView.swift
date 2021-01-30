//
//  MasterListView.swift
//  Web Scraping Tool
//
//  Created by user on 2021/01/03.
//  Copyright © 2021 256hax. All rights reserved.
//

import SwiftUI

struct MasterListView: View {
    @State var showDetail = false
    @Environment(\.managedObjectContext) var viewContext

    // Get ScrapingPageCoreData object from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPageCoreData.name, ascending: true)],
        animation: .default)
    var scrapingPageCoreData: FetchedResults<ScrapingPageCoreData>

    var body: some View {
        List {
            ForEach(scrapingPageCoreData, id: \.self) { s in
                Button(
                    action: {
                        self.showDetail = true
                    }
                ) {
                    VStack {
                        HStack {
                            Text("\(s.name!)")
                                .font(.largeTitle)
                                .fontWeight(.thin)
                                .accessibility(identifier: "master_name_text")
                            Spacer()
                        }
                        HStack {
                            Text("\(s.url!)")
                                .font(.caption)
                                .fontWeight(.thin)
                                .accessibility(identifier: "master_url_text")
                            Spacer()
                        }
                    }
                }
                .sheet(isPresented: self.$showDetail) {
                    DetailEditView(scrapingPageCoreData: s)
                        .environment(\.managedObjectContext, self.viewContext)
                        .environmentObject(DetailViewModel())
                }.navigationViewStyle(StackNavigationViewStyle())
            }.onDelete { indices in
                self.scrapingPageCoreData.delete(at: indices, from: self.viewContext)
            }
        }
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
//        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let scrapingPageCoreData        = ScrapingPageCoreData(context: viewContext)
//        scrapingPageCoreData.uuidString = UUID().uuidString
//        scrapingPageCoreData.name       = "Find \"Example\" words in Example.com"
//        scrapingPageCoreData.url        = "https://example.com/"
//        scrapingPageCoreData.keyword    = "Example"
//        scrapingPageCoreData.updatedAt  = Date()
//
//        return MasterListView().environment(\.managedObjectContext, viewContext)
        
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let coreDataPreviewsModel = CoreDataPreviewsModel()
        let scrapingPageCoreData = coreDataPreviewsModel.createSampleScrapingPage(viewContext: viewContext)

        MasterListView()
            .environment(\.managedObjectContext, viewContext)

        MasterListView()
            .environment(\.managedObjectContext, viewContext)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
