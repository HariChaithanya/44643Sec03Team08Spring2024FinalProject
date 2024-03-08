//
//  RegisterViewController.swift
//  44643Sec03Team08Spring2024FinalProject
//
//  Created by Udaya Sri Naidu on 2/23/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signupBTN: UIButton!
    
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

    @IBAction func signup(_ sender: Any) {
            if nameTF.text == "" {
                showAlert(str: "Please enter your name.")
                return
            }
            
            if emailTF.text == "" {
                showAlert(str: "Please enter your email.")
                return
            }
            
            if !isValidEmail(emailTF.text!) {
                showAlert(str: "Please enter a valid email.")
                return
            }
            
            if passwordTF.text == "" {
                showAlert(str: "Please enter your password.")
                return
            }
            
            if confirmPasswordTF.text == "" {
                showAlert(str: "Please confirm your password.")
                return
            }
            
            if passwordTF.text != confirmPasswordTF.text {
                showAlert(str: "Passwords do not match.")
                return
            }
        }
        
    func showMsg(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
        func isValidEmail(_ email: String) -> Bool {
            return email.contains("@") && email.contains(".")
        }
}

