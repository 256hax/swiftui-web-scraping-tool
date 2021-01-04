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
    @State var showDetail = false
 
    var body: some View {
        VStack {
            NavigationView {
                MasterListView()
                    .navigationBarTitle(Text("Scraping Page"))
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing: Button(
                            action: {
                                self.showDetail = true
                            }
                        ) {
                            Image(systemName: "plus")
                        }
                    )
                .sheet(isPresented: $showDetail) {
                    DetailNewView().environment(\.managedObjectContext, self.viewContext)
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            
            MasterRunView()
            Spacer()
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
