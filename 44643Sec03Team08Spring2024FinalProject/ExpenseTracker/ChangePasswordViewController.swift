//
//  ChangePasswordViewController.swift
//  ExpenseTracker
//
//  Created by Riyaz Hussian on 4/12/24.
//

import UIKit

class ChangePasswordViewController: ViewController {
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    

    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func update(_ sender: UIButton) {
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
