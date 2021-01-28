//
//  WebView.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/30.
//  Copyright © 2020 256hax. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let loadUrl: String
    let webViewViewModel = WebViewViewModel()
    @EnvironmentObject var detailViewModel: DetailViewModel

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // For 2 bytes charactors URL encoding (ex: Japanese)
        let loadUrlEncoding = loadUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        uiView.load(URLRequest(url: URL(string: loadUrlEncoding)!))

        // MARK: Set Location URL to Scraping URL of Text Form
        // Get current location URL in WKWebView when Tap some link.
        self.webViewViewModel.kvo = uiView.observe(\WKWebView.url, options: .new) { view, change in
            if let url = view.url {
                let urlString = "\(url)"
                // For 2 byte charactors (ex: Japanese) URL decoding. Prevent for crash in TextField.
                let urlStringDecoding = urlString.removingPercentEncoding!
                self.detailViewModel.url = urlStringDecoding
            }
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(loadUrl: "https://example.com/")
    }
}
