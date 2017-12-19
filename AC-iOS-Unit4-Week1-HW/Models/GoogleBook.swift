//
//  GoogleBook.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

//Link: https://www.googleapis.com/books/v1/volumes?q=+isbn:0385514239

//Key: AIzaSyDc1ntgB2XOz9dCfAwf0QMmlWitRWFHhAo

//Link: https://www.googleapis.com/books/v1/volumes?q=flowers+inauthor:keyes&key=AIzaSyDc1ntgB2XOz9dCfAwf0QMmlWitRWFHhAo


struct GoogleBook: Codable {
    let items: BookWrapper
}

struct BookWrapper: Codable {
    let volumeInfo: BookDetails
}

struct BookDetails: Codable {
    let title: String
    let subtitle: String?
//    let authors: [String]
//    let publisher: String
//    let publishedDate: String
    let description: String
//    let industryIdentifies: IndustryIdentifierWrapper
    let readingModes: ReadingModesWrapper
//    let pageCount: Int
//    let categories: [String]
//    let averageRating: Int
//    let ratingsCount: Int
//    let maturityRating: String
    let imageLinks: ImageWrapper

}

//struct IndustryIdentifierWrapper: Codable {
//    let type: String
//    let identifier: String
//}

struct ReadingModesWrapper: Codable {
    let text: String
    let image: String
}

struct ImageWrapper: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
