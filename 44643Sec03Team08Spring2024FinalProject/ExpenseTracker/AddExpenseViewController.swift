//
//  AddExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Varshitha Lavu on 4/14/24.
//

import UIKit

protocol ExpenseUpdatedDelegate {
    
    func expenseUpdated() -> Void
}

class AddExpenseViewController: UIViewController {
    
    var delegate: ExpenseUpdatedDelegate?
    
    @IBOutlet weak var categoryBtn: UIButton!
    
    @IBOutlet weak var amountTF: UITextField!
    
    var expense: ExpenseModel?
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add Expense"
        self.tabBarController?.tabBar.isHidden = true
        amountTF.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    
    // Do any additional setup after loading the view.
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func add(_ sender: Any) {
        
    }
}
