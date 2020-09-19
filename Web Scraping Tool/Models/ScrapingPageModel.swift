//
//  ScrapingPageModel.swift
//  Web Scraping Tool
//
//  Created by user on 2020/09/17.
//  Copyright © 2020 256hax. All rights reserved.
//

import Foundation

class UpdateUserInput {
    @Published var name = ""
    @Published var url = ""
    @Published var keyword = ""
}

extension UpdateUserInput: ObservableObject {
}
