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
    @ObservedObject var detailViewModel = DetailViewModel()
    @ObservedObject var testViewModel   = TestViewModel()
    
    var body: some View {
        NavigationView {
            DetailFormView(
                detailViewModel: detailViewModel,
                testViewModel: testViewModel)
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

struct CreateScrapingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewView()
    }
}
