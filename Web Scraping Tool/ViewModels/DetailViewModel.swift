//
//  DetailViewModel.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation
import CoreData

class DetailViewModel: ObservableObject {
    @Published var name     = ""
    @Published var url      = ""
    @Published var keyword  = ""
    
    func create(detailViewModel: DetailViewModel, viewContext: NSManagedObjectContext) {
        ScrapingPageCoreData.create(
            in: viewContext,
            scrapingName: detailViewModel.name,
            scrapingUrl: detailViewModel.url,
            scrapingKeyword: detailViewModel.keyword
        )
    }
    
    func update(detailViewModel: DetailViewModel, scrapingPageCoreData: ScrapingPageCoreData, viewContext: NSManagedObjectContext) {
        ScrapingPageCoreData.update(
            in: viewContext,
            scrapingPageCoreData: scrapingPageCoreData,
            scrapingName: detailViewModel.name,
            scrapingUrl: detailViewModel.url,
            scrapingKeyword: detailViewModel.keyword
        )
    }
    
    // MARK: Set Core Data for nil guard
    func SetCoreData(_ scrapingPageCoreData: ScrapingPageCoreData) {
        self.name       = scrapingPageCoreData.name ?? "new name"
        self.url        = scrapingPageCoreData.url ?? ""
        self.keyword    = scrapingPageCoreData.keyword ?? ""
    }
}
