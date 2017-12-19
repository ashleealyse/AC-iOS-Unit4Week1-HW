//
//  Categories.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

//Link: https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(key)

struct BestSellersCategory: Codable {
    let results: [Category]
}

struct Category: Codable {
    let display_name: String
    let list_name_encoded: String
}

public struct SelectedCategory {
    
    static var manager = SelectedCategory()
    private init() {}
public var selectedCategory = ""
}
