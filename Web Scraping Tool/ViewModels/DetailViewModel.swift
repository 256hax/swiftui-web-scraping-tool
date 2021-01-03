//
//  DetailViewModel.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var name     = ""
    @Published var url      = ""
    @Published var keyword  = ""
}

extension DetailViewModel {
    /// Set Core Data for nil guard
    /// - Parameter scrapingPageCoreData: Core Data object
    func SetCoreData(_ scrapingPageCoreData: ScrapingPageCoreData) {
        self.name       = scrapingPageCoreData.name ?? "new name"
        self.url        = scrapingPageCoreData.url ?? ""
        self.keyword    = scrapingPageCoreData.keyword ?? ""
    }
}
