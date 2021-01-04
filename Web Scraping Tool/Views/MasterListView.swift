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
    var scrapingPagesCoredataModel: FetchedResults<ScrapingPageCoreData>

    var body: some View {
        List {
            ForEach(scrapingPagesCoredataModel, id: \.self) { s in
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
                            Spacer()
                        }
                        HStack {
                            Text("\(s.url!)")
                                .font(.caption)
                                .fontWeight(.thin)
                            Spacer()
                        }
                    }
                }
                .sheet(isPresented: self.$showDetail) {
                    DetailEditView(scrapingPageCoreData: s).environment(\.managedObjectContext, self.viewContext)
                }
            }.onDelete { indices in
                self.scrapingPagesCoredataModel.delete(at: indices, from: self.viewContext)
            }
        }
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MasterListView().environment(\.managedObjectContext, context)
    }
}
