//
//  ScrapingDetail.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/13.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct ScrapingDetail: View {
    @ObservedObject var event: Event

    var body: some View {
        Text("detail page")
            .navigationBarTitle(Text("Detail"))
    }
}

//struct ScrapingDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrapingDetail()
//    }
//}
