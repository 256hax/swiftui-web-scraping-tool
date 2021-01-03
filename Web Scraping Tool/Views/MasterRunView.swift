//
//  MasterRunView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/10/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct MasterRunView: View {
    @State var isRunning: Bool = false
    @State var isButtonEnabled: Bool = false
    @ObservedObject var scrapingPageMasterService = RunViewModel()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPageCoreData.updatedAt, ascending: false)],
        animation: .default
    )
    var scrapingPageCoreData: FetchedResults<ScrapingPageCoreData>

    var body: some View {
        VStack {
            Button(action: {
                self.isRunning.toggle()
                
                if(self.isRunning) {
                    scrapingPageMasterService.startScraping(scrapingPageCoreData: self.scrapingPageCoreData)
                } else {
                    scrapingPageMasterService.stopScraping()
                }
            }) {
                Image(systemName: self.isRunning ? "stop.fill" : "play.fill")
            }
            .disabled(!self.isButtonEnabled)
            .padding()
            
            Text(String(format: "Next Scraping %.1f", scrapingPageMasterService.countdownTimer))
            Text(scrapingPageMasterService.runningTestResult)
                .font(.caption)
        }.onAppear(perform: {
            self.getAuthorization()
        })
    }
    
    func getAuthorization() {
       let center = UNUserNotificationCenter.current()
        
       center.getNotificationSettings(completionHandler: { settings in
          if settings.authorizationStatus == .authorized {
             self.isButtonEnabled = true
          } else {
             center.requestAuthorization(options: [.alert, .sound], completionHandler: { granted, error in
                if granted && error == nil {
                   self.isButtonEnabled = true
                } else {
                   self.isButtonEnabled = false
                }
             })
          }
       })
        
    }
}

struct ScrapingPageMasterRun_Previews: PreviewProvider {
    static var previews: some View {
        MasterRunView()
    }
}
