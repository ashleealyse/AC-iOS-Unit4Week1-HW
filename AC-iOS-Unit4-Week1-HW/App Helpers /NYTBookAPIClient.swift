//
//  NYTBookAPIClient.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct NYTBookAPIClient{
    private init() {}
    static let manager = NYTBookAPIClient()
    func getNYTBookInfo(from urlStr: String, completionHandler: @escaping ([BestSellersWrapper]) -> Void, errorHandler: @escaping (AppError) -> Void){
        
        
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let bestSellers = try myDecoder.decode(BestSellers.self, from: data)
                completionHandler(bestSellers.results)
                
                
            } catch{
                print("Best Sellers in NYTBookAPIClient Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
}
}
