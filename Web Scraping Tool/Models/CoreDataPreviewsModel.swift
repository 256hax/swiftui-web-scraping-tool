//
//  CoreDataPreviewsModel.swift
//  Web Scraping Tool
//
//  Created by user on 2021/01/30.
//  Copyright © 2021 256hax. All rights reserved.
//

import Foundation
import CoreData

/// Core Data Sample Data for Previews
class CoreDataPreviewsModel {
    
    /// Create ScrapingPageCoreData sample data
    /// - Parameter viewContext: NSManagedObjectContext
    /// - Returns: Created sample Core Data
    /// - Note: Shouldn't write this code to Previews area directly.
    @discardableResult
    func createSampleScrapingPage(viewContext: NSManagedObjectContext) -> ScrapingPageCoreData {
        let scrapingPageCoreData        = ScrapingPageCoreData(context: viewContext)
        scrapingPageCoreData.uuidString = UUID().uuidString
        scrapingPageCoreData.name       = "Find Example"
        scrapingPageCoreData.url        = "https://example.com/"
        scrapingPageCoreData.keyword    = "Example"
        scrapingPageCoreData.updatedAt  = Date()
        
        return scrapingPageCoreData
    }
}
