//
//  SettingsViewController.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    //Outlets
    @IBOutlet weak var pickerView: UIPickerView!
    
    //Variables
    var categories = [Category]() {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        loadCategories()
    
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        if let newName = nameTextField.text {
//            UserDefaultHelper.manager.setName(to: newName)
//        }
//        let newSign = signs[pickerView.selectedRow(inComponent: 0)]
//        UserDefaultHelper.manager.setSign(to: newSign)
//    }
//}

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
        print(categories.count)
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categories[row].display_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedCategory.manager.selectedCategory = categories[row].display_name
        UserDefaultHelper.manager.setCategory(to: SelectedCategory.manager.selectedCategory)
        print(SelectedCategory.manager.selectedCategory)
    }
    
    

    
    
}
