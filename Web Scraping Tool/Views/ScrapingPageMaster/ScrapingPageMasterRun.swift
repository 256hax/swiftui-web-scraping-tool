//
//  ScrapingPageMasterRun.swift
//  Web Scraping Tool
//
//  Created by user on 2020/10/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct ScrapingPageMasterRun: View {
    @State var isRunning: Bool = false
    var scrapingPageMasterService = ScrapingPageMasterService()

    var body: some View {
        // Scraping Start/Stop
        if(scrapingPageMasterService.isScraping) {
            ProgressView("Scraping...")
        }
        Button(action: {
            self.isRunning.toggle()
            scrapingPageMasterService.controlScraping(isRunning: self.isRunning)
        }) {
            Image(systemName: self.isRunning ? "play.fill" : "stop.fill")
        }
    }
}

struct ScrapingPageMasterRun_Previews: PreviewProvider {
    static var previews: some View {
        ScrapingPageMasterRun()
    }
}
