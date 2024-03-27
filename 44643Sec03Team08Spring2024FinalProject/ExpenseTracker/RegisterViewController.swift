//
//  RegisterViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 21/02/2024.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
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

    @IBAction func register(_ sender: Any) {
        
        if nameTF.text == "" {
            
            self.showAlert(str: "Please enter email")
            return
        }
        
        if emailTF.text == "" {
            
            self.showAlert(str: "Please enter email")
            return
        }
        
        if passwordTF.text == "" {
            
            self.showAlert(str: "Please enter password")
            return
        }
        
        if confirmPasswordTF.text == "" {
            
            self.showAlert(str: "Please enter email")
            return
        }
        
        
        
    }
}
