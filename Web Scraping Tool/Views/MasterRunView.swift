//
//  MasterRunView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/10/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI

struct MasterRunView: View {
    /// - Note: Shouldn't Enabling Button move to outside(ex: ViewModel). To be following an error.
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
            Text("Do not close this app while scraping.")
                .font(.caption)
            Button(action: {
                runViewModel.isRunning.toggle()
                
                if(runViewModel.isRunning) {
                    runViewModel.startScraping(scrapingPageCoreData: self.scrapingPageCoreData)
                } else {
                    runViewModel.stopScraping()
                }
            }) {
                Image(systemName: runViewModel.isRunning ? "stop.fill" : "play.fill")
                    .accessibility(identifier: "master_run_button")
            }
            .disabled(!self.isButtonEnabled)
            .padding()
            
            Text("Next Scraping ") + Text(String(runViewModel.countdownTimer))
            Text(runViewModel.runningResult)
                .font(.caption)
        }.onAppear(perform: {
            self.getAuthorization()
        })
    }
    
    /// Get Authorization for Notification
    /// - Note: Shouldn't move to outslide(ex: ViewModel).
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

struct MasterRunView_Previews: PreviewProvider {
    static var previews: some View {
        MasterRunView()
        MasterRunView().environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
