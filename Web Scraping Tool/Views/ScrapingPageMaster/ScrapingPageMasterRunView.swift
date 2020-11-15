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

    var body: some View {
        VStack {
            Text(String(format: "Next Scraping %.1f", scrapingPageMasterService.countdownTimer))
            
            Button(action: {
                self.isRunning.toggle()
                
                if(self.isRunning) {
                    scrapingPageMasterService.startScraping(scrapingPagesCoredataModel: self.scrapingPagesCoredataModel)
                } else {
                    scrapingPageMasterService.stopScraping()
                }
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
