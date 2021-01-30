//
//  DetailNewView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/07/05.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct DetailNewView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var detailViewModel: DetailViewModel
    @ObservedObject var testViewModel = TestViewModel()
    
    var body: some View {
        NavigationView {
            DetailFormView(
                testViewModel: testViewModel
            )
            .navigationBarItems(
                leading: Text("New Scraping Page"),
                trailing: Button(
                    action: {
                        detailViewModel.create(detailViewModel: detailViewModel, viewContext: viewContext)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Text("Save")
                        .accessibility(identifier: "detailNew_create_button")
                }
            )
        }
    }
}

struct DetailNewView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        DetailNewView()
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(DetailViewModel())
        
        DetailNewView()
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(DetailViewModel())
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
