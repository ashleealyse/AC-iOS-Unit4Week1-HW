//
//  GoogleBook.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation



struct GoogleBook: Codable {
    let items: [BookWrapper]
}

struct BookWrapper: Codable {
    let volumeInfo: BookDetails
}

struct BookDetails: Codable {
    let title: String
    let subtitle: String?
    let description: String
    let imageLinks: ImageWrapper?

}

struct ImageWrapper: Codable {
    let thumbnail: String
    let smallThumbnail: String
}
