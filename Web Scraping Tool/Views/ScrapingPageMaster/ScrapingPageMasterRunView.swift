//
//  ScrapingPageMasterRun.swift
//  Web Scraping Tool
//
//  Created by user on 2020/10/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct ScrapingPageMasterRunView: View {
    @State var isRunning: Bool = false
    @ObservedObject var scrapingPageMasterService = ScrapingPageMasterService()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPageCoredataModel.updatedAt, ascending: false)],
        animation: .default
    )
    var scrapingPagesCoredataModel: FetchedResults<ScrapingPageCoredataModel>

    var runningTestResultText: String {
        return scrapingPageMasterService.runningTestResult
    }
    
    var body: some View {
        VStack {
            if(scrapingPageMasterService.isScraping) {
                ProgressView("Scraping...")
            } else {
                Text(runningTestResultText)
            }
            
            Button(action: {
                self.isRunning.toggle()
                scrapingPageMasterService.runScraping(scrapingPagesCoredataModel: self.scrapingPagesCoredataModel)
            }) {
                Image(systemName: self.isRunning ? "stop.fill" : "play.fill")
            }
        }
    }
}

struct ScrapingPageMasterRun_Previews: PreviewProvider {
    static var previews: some View {
        ScrapingPageMasterRunView()
    }
}
