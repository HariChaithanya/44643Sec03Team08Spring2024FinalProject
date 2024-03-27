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
        costView.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
