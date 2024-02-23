//
//  DashboardVC.swift
//  44643Sec03Team08Spring2024FinalProject
//
//  Created by Varshitha Lavu on 2/23/24.
//

import UIKit

class DashboardVC: UIViewController {

    
    @IBOutlet weak var costView: UILabel!
    
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
