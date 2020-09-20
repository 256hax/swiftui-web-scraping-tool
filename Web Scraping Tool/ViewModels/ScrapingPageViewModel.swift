//
//  ScrapingPageModel.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation
import CoreData

class ScrapingPageViewModel: ObservableObject {
    @Published var name = ""
    @Published var url = ""
    @Published var keyword = ""
}

extension ScrapingPageViewModel {
    func SetCoredata(_ scrapingPage: ScrapingPageCoredataModel) {
        self.name    = scrapingPage.name ?? "new name"
        self.url     = scrapingPage.url ?? ""
        self.keyword = scrapingPage.keyword ?? ""
    }
}
