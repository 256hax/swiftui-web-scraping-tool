//
//  MasterRunView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/10/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct MasterRunView: View {
    /// - Note: Shouldn't Enabling Button move to outside. It get following error.
    /// -> Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
    @State var isButtonEnabled: Bool = false
    @ObservedObject var runViewModel = RunViewModel()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ScrapingPageCoreData.updatedAt, ascending: false)],
        animation: .default
    )
    var scrapingPageCoreData: FetchedResults<ScrapingPageCoreData>

    var body: some View {
        VStack {
            Button(action: {
                runViewModel.isRunning.toggle()
                
                if(runViewModel.isRunning) {
                    runViewModel.startScraping(scrapingPageCoreData: self.scrapingPageCoreData)
                } else {
                    runViewModel.stopScraping()
                }
            }) {
                Image(systemName: runViewModel.isRunning ? "stop.fill" : "play.fill")
            }
            .disabled(!self.isButtonEnabled)
            .padding()
            
            Text(String(format: "Next Scraping %.1f", runViewModel.countdownTimer))
            Text(runViewModel.runningResult)
                .font(.caption)
        }.onAppear(perform: {
            self.getAuthorization()
        })
    }
    
    
    /// Get Authorization for Notification
    /// - Note: Shouldn't move to outslide file.
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
