//
//  ScrapingPage+extensions.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/18.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation
import CoreData

extension ScrapingPage: Identifiable {
}

extension ScrapingPage {
    static func create(in viewContext: NSManagedObjectContext, scrapingName: String, scrapingUrl: String) {
        let newScrapingPage       = ScrapingPage(context: viewContext)
        newScrapingPage.name      = scrapingName.isEmpty ? "No Name" : scrapingName
        newScrapingPage.url       = scrapingUrl
        newScrapingPage.updatedAt = Date()
        
        do {
            try  viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func update(in viewContext: NSManagedObjectContext, scrapingPage: ScrapingPage, scrapingName: String, scrapingUrl: String) {
        let scrapingPage        = scrapingPage
        scrapingPage.name       = scrapingName
        scrapingPage.url        = scrapingUrl
        scrapingPage.updatedAt  = Date()
        
        do {
            try  viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

extension Collection where Element == ScrapingPage, Index == Int {
    func delete(at indices: IndexSet, from managedObjectContext: NSManagedObjectContext) {
        indices.forEach { managedObjectContext.delete(self[$0]) }
 
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
