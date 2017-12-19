//
//  NYTAPIClient.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

//Key: e0dad52307ed4af4bf70869d3be66558

//Link: 

struct NYTAPIClient{
    private init() {}
    static let manager = NYTAPIClient()
    func getNYTBookInfo(from urlStr: String, completionHandler: @escaping ([Category]) -> Void, errorHandler: @escaping (AppError) -> Void){
        
        
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let categories = try myDecoder.decode(BestSellersCategory.self, from: data)
               completionHandler(categories.results)
               
                
            } catch{
                print("Category in NYTAPIClient Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    //
    //    func post(elementPost: ElementPost, completionHandler: (ElementPost) -> Void, errorHandler: (Error) -> Void){
    //
    //        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
    //
    //        guard var authPostRequest = buildAuthRequest(urlStr: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return } //url request with all of your stuff in it from all of the functions you build: Authdentication, URL, httpMethod, get or post and the json object you are sending over using a json encoder turning it into data you can send
    //
    //
    //        do {
    //            let enocodedElementPost = try JSONEncoder().encode(elementPost)
    //            authPostRequest.httpBody = enocodedElementPost
    //            NetworkHelper.manager.performDataTask(with: authPostRequest , completionHandler: {print($0)}, errorHandler: {print($0)})
    //        } catch {
    //            print(error)
    //
    //        }
    //
    //
    //
    //    }
    //
    //    //Builds Auth Request
    //    private func buildAuthRequest(urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
    //        guard let url = URL(string: urlStr) else {return nil} //making sure your string is a url
    //
    //        var request = URLRequest(url: url) //making a urlRequest
    //
    //        let userName = "key-1" //username and password for authentication
    //        let password = "ptJP0XOFIQ_xysF7nwoB"
    //
    //        let authStr = buildAuthStr(userName: userName, password: password)
    //
    //        request.addValue(authStr, forHTTPHeaderField: "Authorization")
    //
    //        if httpVerb == .POST {
    //            request.httpMethod = "POST"
    //            request.addValue("application/json", forHTTPHeaderField: "Accept")
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        }
    //        return request
    //    }
    //
    //
    //    private func buildAuthStr(userName: String, password: String) -> String {
    //        let nameAndPassStr = "\(userName):\(password)"
    //        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
    //        let authBase64Str = nameAndPassData.base64EncodedString()
    //        let authStr = "Basic \(authBase64Str)"
    //        return authStr
    //    }
    //
    //
    //
    //
    //
    //    enum HTTPVerb {
    //        case POST
    //        case GET
    //    }
}
