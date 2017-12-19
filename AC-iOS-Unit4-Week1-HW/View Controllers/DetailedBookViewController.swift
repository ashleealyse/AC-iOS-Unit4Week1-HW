//
//  DetailedBookViewController.swift
//  AC-iOS-Unit4-Week1-HW
//
//  Created by Ashlee Krammer on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedBookViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var detailedBookImage: UIImageView!
    @IBOutlet weak var detailedBookText: UITextView!
    
    //Actions
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    
    //Variables
    var bestSeller: BestSellersWrapper!
    var textBox = ""
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadDetailedBook() {
        
        
        
//        textBox =
//        """
//        \(bestSeller.)
//        """
    }
}
