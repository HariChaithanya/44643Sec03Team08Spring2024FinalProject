//
//  ChangePasswordViewController.swift
//  ExpenseTracker
//
//  Created by Riyaz Hussian on 4/12/24.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: ViewController {
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func update(_ sender: UIButton) {
    
    self.view.endEditing(true)
    if self.validateData() {
        
        self.showSpinner(onView: self.view)
        
        Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { (error) in
            
            
            if error != nil {
                
                self.removeSpinner()
                self.showAlert(str: error?.localizedDescription ?? "")
            }else {
                
                self.removeSpinner()
                let alert = UIAlertController(title: "", message: "Password changed successfully", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
                    
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(ok)
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
            }
        }
    }
}

func validateData() -> Bool {
    
    if password.text == "" {
        
        self.showAlert(str: "Password is required")
        return false
    }else if newPassword.text == "" {
        
        self.showAlert(str: "New Password is required")
        return false
    }else if confirmPassword.text == "" {
        
        self.showAlert(str: "Confirm Password is required")
        return false
    }
    
    return true
}

}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


