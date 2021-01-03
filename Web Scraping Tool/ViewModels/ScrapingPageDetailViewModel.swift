//
//  ScrapingPageModel.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

class ScrapingPageDetailViewModel: ObservableObject {
    @Published var name = ""
    @Published var url = ""
    @Published var keyword = ""
}

extension ScrapingPageDetailViewModel {
    func SetCoredata(_ scrapingPageCoreData: ScrapingPageCoreData) {
        self.name    = scrapingPageCoreData.name ?? "new name"
        self.url     = scrapingPageCoreData.url ?? ""
        self.keyword = scrapingPageCoreData.keyword ?? ""
    }
}
