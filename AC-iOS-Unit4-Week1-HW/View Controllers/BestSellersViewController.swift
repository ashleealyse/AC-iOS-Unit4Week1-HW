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
    var cellSpacing = UIScreen.main.bounds.size.width * 0.05
    
    
    
    var books = [BookWrapper?]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    var categories = [Category]() {
        didSet {
            pickerView.reloadAllComponents()
            
            if UserDefaultHelper.manager.getCategory() != nil {
                pickerView.selectRow(UserDefaultHelper.manager.getCategory()!, inComponent: 0, animated: false)
            } else {
                pickerView.selectRow(0, inComponent: 0, animated: false)
            }
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
    
    
    func loadBooks(book bestSeller: BestSellersWrapper, cell currentCell: BestSellerCollectionViewCell) {
        
        let isbn = bestSeller.isbns[0].isbn13
        
        let urlStr = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyDc1ntgB2XOz9dCfAwf0QMmlWitRWFHhAo"
        
        let completion: ([BookWrapper]) -> Void = {(onlineGoogleBook: [BookWrapper]) in
            if let imageUrl = onlineGoogleBook[0].volumeInfo.imageLinks?.thumbnail {
                
                let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                    
                    currentCell.bestSellerBookImage.image = onlineImage
                    currentCell.setNeedsLayout()
                    
                }
                
                ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: completion, errorHandler: {print($0)})
                
            } else {
                
                currentCell.bestSellerBookImage.image = #imageLiteral(resourceName: "no_book_cover")
                currentCell.setNeedsLayout()
                
            }
            self.books.append(onlineGoogleBook[0])
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
        
        GoogleAPIClient.manager.getGoogleInfo(from: urlStr, completionHandler: completion, errorHandler: errorHanlder)
        
    }
    
    
    
    
    
    
    func loadBestSellers(categoryStr: String){
        let urlStr = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=e0dad52307ed4af4bf70869d3be66558&list=\(categoryStr)"
        
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaultHelper.manager.getCategory() != nil {
            self.pickerView.selectRow(UserDefaultHelper.manager.getCategory()!, inComponent: 0, animated: false)
            
            if categories.isEmpty {
                return
                
            } else {
                loadBestSellers(categoryStr: categories[UserDefaultHelper.manager.getCategory()!].list_name_encoded)
            }
        }
    }
    
    
    
    
    
    
    func loadCategories(){
        
        let urlStr = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=e0dad52307ed4af4bf70869d3be66558"
        
        let completion = {(onlineCategories: [Category]) in
            self.categories = onlineCategories
            if UserDefaultHelper.manager.getCategory() != nil {
                self.loadBestSellers(categoryStr: self.categories[UserDefaultHelper.manager.getCategory()!].list_name_encoded)
            } else {
                self.loadBestSellers(categoryStr: self.categories[0].list_name_encoded)
            }
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
  
       loadBestSellers(categoryStr: categories[row].list_name_encoded)
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
            loadBooks(book: aBook, cell: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedBookViewController {
//            let selectedBook = bestSellers[indexPa]
//            destination.bestSellers = selectedBook
        }
    }

    
    
}

extension BestSellersViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numCells: CGFloat = 1
        let numSpaces: CGFloat = numCells
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}




