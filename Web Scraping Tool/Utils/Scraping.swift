//
//  Scraping.swift
//  Web Scraping Tool
//
//  Created by user on 2020/08/03.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

struct Scraping {
    func crawling() {
        let inputUrl: String = "https://example.com/"
        let encodingUrl: String = inputUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodingUrl)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let data = data else {
            print("Data was nil.")
            return
          }
            
          guard let htmlString = String(data: data, encoding: .utf8) else {
            print("Couldn't cast data into String.")
            return
          }
//          print(htmlString)
        }

        task.resume()
    }
}
