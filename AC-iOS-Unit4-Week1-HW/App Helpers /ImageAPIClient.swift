//
//  ImageAPIClient.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient{
    private init() {}
    static let manager = ImageAPIClient()
    
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void){
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else{
                errorHandler(.notAnImage)
                return
            }
            completionHandler(onlineImage)
        }
        
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
    }
}
