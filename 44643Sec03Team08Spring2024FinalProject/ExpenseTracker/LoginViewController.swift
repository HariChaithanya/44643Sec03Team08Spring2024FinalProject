//
//  LoginViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 21/02/2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        if emailTF.text == "" {
            
            self.showAlert(str: "Please enter a valid email")
            return
        }
        
        if passwordTF.text == "" {
            
            self.showAlert(str: "Please enter password field")
            return
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBar") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTF.text = ""
        passwordTF.text = ""
    }
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        guard let email = emailTF.text, !email.isEmpty else {
            showAlert(message: "Please enter your email to reset password")
            return
        }
        showAlert(message: "Password reset link sent to \(email)")
    }
}
