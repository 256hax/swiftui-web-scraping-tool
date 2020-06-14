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
//                            withAnimation { Event.create(in: self.viewContext) }
                            self.showScrapingDetail = true
                        }
                    ) {
                        Image(systemName: "plus")
                    }
                )
//            Text("Detail view content goes here")
//                .navigationBarTitle(Text("Detail"))
            .sheet(isPresented: $showScrapingDetail) {
                DetailView()
            }
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.timestamp, ascending: true)],
        animation: .default)
    var events: FetchedResults<Event>

    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        List {
            ForEach(events, id: \.self) { event in
                NavigationLink(
//                    destination: DetailView(event: event)
                    destination: DetailView()
                ) {
                    Text("\(event.timestamp!, formatter: dateFormatter)")
                }
            }.onDelete { indices in
                self.events.delete(at: indices, from: self.viewContext)
            }
        }
    }
}

struct DetailView: View {
//    @ObservedObject var event: Event
    @Environment (\.presentationMode) var presentationMode
    @State var title = ""

    var body: some View {
//        Text("\(event.timestamp!, formatter: dateFormatter)")
//            .navigationBarTitle(Text("Detail"))
//        Text("detail page")
        NavigationView {
            Form {
                Group {
                    TextField("Scraping Title", text: $title)
                }
            }
            .navigationBarItems(
                leading: Text("Add Scraping"),
//                trailing: Button("Save") {
//                    self.presentationMode.wrappedValue.dismiss()
//                }
                trailing: Button(
                    action: {
                        print("saved")
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
