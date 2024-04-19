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
        
        guard let currentPassword = password.text, !currentPassword.isEmpty else {
            self.showAlert(str: "Current Password is required")
            return
        }
        
        guard let newPassword = newPassword.text, !newPassword.isEmpty else {
            self.showAlert(str: "New Password is required")
            return
        }
        
        guard let confirmPassword = confirmPassword.text, !confirmPassword.isEmpty else {
            self.showAlert(str: "Confirm Password is required")
            return
        }
        
        // Check if new password matches confirm password
        guard newPassword == confirmPassword else {
            self.showAlert(str: "New password and confirm password do not match")
            return
        }
        
        // Authenticate the user
        guard let currentUser = Auth.auth().currentUser else {
            self.showAlert(str: "User not authenticated")
            return
        }
        
        // Reauthenticate the user with their current password
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: currentPassword)
        currentUser.reauthenticate(with: credential) { [weak self] (authResult, error) in
            guard let self = self else { return }
            
            if let error = error {
                // Show alert for incorrect current password
                self.showAlert(str: "Please enter correct current password")
                return
            }
            
            // User has been reauthenticated successfully, update password
            self.showSpinner(onView: self.view)
            currentUser.updatePassword(to: newPassword) { [weak self] (error) in
                guard let self = self else { return }
                
                self.removeSpinner()
                
                if let error = error {
                    // Show alert for password update error
                    self.showAlert(str: error.localizedDescription)
                } else {
                    // Password changed successfully, show success alert
                    let alert = UIAlertController(title: "", message: "Password changed successfully", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alert.addAction(ok)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
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


