//
//  ContentView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/13.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct ContentView: View {
    // Handling for CoreData Object
    @Environment(\.managedObjectContext) var viewContext
    @State var showScrapingDetail = false
 
    var body: some View {
        NavigationView {
            MasterView()
                .navigationBarTitle(Text("Master"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
                            self.showScrapingDetail = true
                        }
                    ) {
                        Image(systemName: "plus")
                    }
                )
            .sheet(isPresented: $showScrapingDetail) {
                CreateScrapingView().environment(\.managedObjectContext, self.viewContext)
            }
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    @State var showScrapingDetail = false
    @Environment(\.managedObjectContext) var viewContext

    // Get ScrapingPage object from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPage.updatedAt, ascending: false)],
        animation: .default)
    var scrapingPages: FetchedResults<ScrapingPage>

    var body: some View {
        List {
            ForEach(scrapingPages, id: \.self) { scrapingPage in
                Button(
                    action: {
                        self.showScrapingDetail = true
                    }
                ) {
                    Text("\(scrapingPage.name!)")
                }
                .sheet(isPresented: self.$showScrapingDetail) {
                    UpdateScrapingView(scrapingPage: scrapingPage).environment(\.managedObjectContext, self.viewContext)
                }
            }.onDelete { indices in
                self.scrapingPages.delete(at: indices, from: self.viewContext)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
