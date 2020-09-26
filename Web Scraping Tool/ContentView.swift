//
//  ContentView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/13.
//  Copyright © 2020 256hax. All rights reserved.
//
import SwiftUI

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
                NewScrapingPageView().environment(\.managedObjectContext, self.viewContext)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct MasterView: View {
    @State var showScrapingDetail = false
    @Environment(\.managedObjectContext) var viewContext

    // Get ScrapingPageCoredataModel object from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPageCoredataModel.updatedAt, ascending: false)],
        animation: .default)
    var scrapingPagesCoredataModel: FetchedResults<ScrapingPageCoredataModel>

    var body: some View {
        List {
            ForEach(scrapingPagesCoredataModel, id: \.self) { scrapingPageCoredataModel in
                Button(
                    action: {
                        self.showScrapingDetail = true
                    }
                ) {
                    HStack {
                        Text("\(scrapingPageCoredataModel.name!)")
                    }
                }
                .sheet(isPresented: self.$showScrapingDetail) {
                    EditScrapingPageView(scrapingPageCoredataModel: scrapingPageCoredataModel).environment(\.managedObjectContext, self.viewContext)
                }
            }.onDelete { indices in
                self.scrapingPagesCoredataModel.delete(at: indices, from: self.viewContext)
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
