//
//  BestSellersViewController.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BestSellersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //Outlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var categories = [Category]() {
        didSet {
            pickerView.reloadAllComponents()
            
        }
    }
    
    var bestSellers = [BestSellersWrapper]() {
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        loadCategories()
        
        
    }
    
    
    func loadBestSellers(){
        let urlStr = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=e0dad52307ed4af4bf70869d3be66558&list=\(SelectedCategory.manager.selectedCategory)"
        
        let completion = {(onlineBestSellers: [BestSellersWrapper]) in
            self.bestSellers = onlineBestSellers
        }
        
        
        let errorHanlder: (AppError) -> Void = {(error: AppError) in
            switch error{
            case .noInternetConnection:
                print("No internet connection")
            case .couldNotParseJSON:
                print("Could Not Parse")
            case .badStatusCode:
                print("Bad Status Code")
            case .badURL:
                print("Bad URL")
            case .invalidJSONResponse:
                print("Invalid JSON Response")
            case .noDataReceived:
                print("No Data Received")
            case .notAnImage:
                print("No Image Found")
            default:
                print("Other error")
            }
        }
        
        NYTBookAPIClient.manager.getNYTBookInfo(from: urlStr,
                                                completionHandler: completion,
                                                errorHandler: errorHanlder)
        
    }
    
    
    
    
    
    
    
    
    
    
    func loadCategories(){
        
        let urlStr = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=e0dad52307ed4af4bf70869d3be66558"
        
        let completion = {(onlineCategories: [Category]) in
            self.categories = onlineCategories
        }
        
        
        let errorHanlder: (AppError) -> Void = {(error: AppError) in
            switch error{
            case .noInternetConnection:
                print("No internet connection")
            case .couldNotParseJSON:
                print("Could Not Parse")
            case .badStatusCode:
                print("Bad Status Code")
            case .badURL:
                print("Bad URL")
            case .invalidJSONResponse:
                print("Invalid JSON Response")
            case .noDataReceived:
                print("No Data Received")
            case .notAnImage:
                print("No Image Found")
            default:
                print("Other error")
            }
        }
        
        NYTAPIClient.manager.getNYTBookInfo(from: urlStr,
                                            completionHandler: completion,
                                            errorHandler: errorHanlder)
    }
    
    //Picker View Data Source Requirements
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categories[row].display_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedCategory.manager.selectedCategory = categories[row].list_name_encoded
        UserDefaultHelper.manager.setCategory(to: SelectedCategory.manager.selectedCategory)
        print(SelectedCategory.manager.selectedCategory)
        loadBestSellers()
    }
    
    
}




extension BestSellersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //Num of Sections
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(bestSellers.count)
        return bestSellers.count
    }
    
    //Cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestSellersCell", for: indexPath)
        let aBook = bestSellers[indexPath.row]
        if let cell = cell as? BestSellerCollectionViewCell {
            cell.bestSellerDetailedText.text = aBook.book_details[0].bestSellerDetail
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}





