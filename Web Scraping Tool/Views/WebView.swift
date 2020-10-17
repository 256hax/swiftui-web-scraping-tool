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
    var loadUrl: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: loadUrl)!))
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(loadUrl: "https://example.com/")
    }
}