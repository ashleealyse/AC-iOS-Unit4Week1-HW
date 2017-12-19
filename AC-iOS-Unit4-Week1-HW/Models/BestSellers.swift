//
//  BestSellers.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

//Link: https://api.nytimes.com/svc/books/v3/lists.json?api-key=e0dad52307ed4af4bf70869d3be66558&list=\(selectedCategory)
//(e.g Hardcover-Fiction)
//Key: e0dad52307ed4af4bf70869d3be66558

struct BestSellers: Codable {
    let results: [BestSellersWrapper]
}

struct BestSellersWrapper: Codable {
    let weeks_on_list: Int
    let book_details: [BookInfoWrapper]
    let isbns: [ISBNWrapper]
}

struct BookInfoWrapper: Codable {
    let bestSellerDetail: String
    
    enum CodingKeys: String, CodingKey {
        case bestSellerDetail = "description"
    }
}

struct ISBNWrapper: Codable {
    let isbn10: String
    let isbn13: String
}



//Description
//Image
//Num of weeks

