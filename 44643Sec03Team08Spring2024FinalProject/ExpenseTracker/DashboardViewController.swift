//
//  DashboardViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 21/02/2024.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet var costView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Dashboard"
        self.navigationItem.hidesBackButton = true
        costView.layer.cornerRadius = 9
        
    }
    
    
    


}
