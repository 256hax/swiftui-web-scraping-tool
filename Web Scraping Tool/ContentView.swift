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
                DetailView().environment(\.managedObjectContext, self.viewContext)
            }
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPage.id, ascending: true)],
        animation: .default)
    var scrapingPages: FetchedResults<ScrapingPage>

    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        List {
            ForEach(scrapingPages, id: \.self) { scrapingPage in
                NavigationLink(
                    destination: DetailView()
                ) {
                    Text("\(scrapingPage.name!)")
                }
            }.onDelete { indices in
                self.scrapingPages.delete(at: indices, from: self.viewContext)
            }
        }
    }
}

struct DetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State var scrapingName = ""
    @State var scrapingUrl = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Scraping Name", text: $scrapingName)
                    TextField("Scraping Url", text: $scrapingUrl)
                }
            }
            .navigationBarItems(
                leading: Text("Add Scraping"),
                trailing: Button(
                    action: {
                        ScrapingPage.create(
                            in: self.viewContext,
                            scrapingName: self.scrapingName,
                            scrapingUrl: self.scrapingUrl
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
