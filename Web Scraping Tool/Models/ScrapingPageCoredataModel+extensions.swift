//
//  ScrapingPageCoredataModel+extensions.swift
//  Web Scraping Tool
//
//  Created by user on 2020/06/18.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

extension ScrapingPageCoredataModel {
    static func create(in viewContext: NSManagedObjectContext, scrapingName: String, scrapingUrl: String, scrapingKeyword: String) {
        let scrapingPageCoredataModel       = ScrapingPageCoredataModel(context: viewContext)
        scrapingPageCoredataModel.uuidString        = UUID().uuidString
        scrapingPageCoredataModel.name      = scrapingName.isEmpty ? "No Name" : scrapingName
        scrapingPageCoredataModel.url       = scrapingUrl
        scrapingPageCoredataModel.keyword   = scrapingKeyword
        scrapingPageCoredataModel.updatedAt = Date()
        
        do {
            try  viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func update(in viewContext: NSManagedObjectContext, scrapingPageCoredataModel: ScrapingPageCoredataModel, scrapingName: String, scrapingUrl: String, scrapingKeyword: String) {
        let scrapingPageCoredataModel       = scrapingPageCoredataModel
        scrapingPageCoredataModel.name      = scrapingName
        scrapingPageCoredataModel.url       = scrapingUrl
        scrapingPageCoredataModel.keyword   = scrapingKeyword
        scrapingPageCoredataModel.updatedAt = Date()
        
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

extension Collection where Element == ScrapingPageCoredataModel, Index == Int {
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
