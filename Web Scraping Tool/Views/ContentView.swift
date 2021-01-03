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
    @State var isRunning: Bool = false
 
    var body: some View {
        VStack {
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
                    DetailNewView().environment(\.managedObjectContext, self.viewContext)
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            
            // Scraping Manager
            MasterRunView()
            Spacer()
        }
    }
}


struct MasterView: View {
    @State var showScrapingDetail = false
    @Environment(\.managedObjectContext) var viewContext

    // Get ScrapingPageCoreData object from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPageCoreData.updatedAt, ascending: false)],
        animation: .default)
    var scrapingPagesCoredataModel: FetchedResults<ScrapingPageCoreData>

    var body: some View {
        List {
            ForEach(scrapingPagesCoredataModel, id: \.self) { s in
                Button(
                    action: {
                        self.showScrapingDetail = true
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
                .sheet(isPresented: self.$showScrapingDetail) {
                    DetailEditView(scrapingPageCoreData: s).environment(\.managedObjectContext, self.viewContext)
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
