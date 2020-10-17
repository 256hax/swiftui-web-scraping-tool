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
    func SetCoredata(_ scrapingPageCoredataModel: ScrapingPageCoredataModel) {
        self.name    = scrapingPageCoredataModel.name ?? "new name"
        self.url     = scrapingPageCoredataModel.url ?? ""
        self.keyword = scrapingPageCoredataModel.keyword ?? ""
    }
}
