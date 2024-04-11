//
//  ProfileViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 06/03/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Profile"
        // Do any additional setup after loading the view.
    }
    
    
    
    
    //cha
    func navigateToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            UIApplication.shared.keyWindow?.rootViewController = loginVC
        }
        
//        @IBAction func logout(_ sender: UIButton) {
//            
//            navigateToLoginScreen()
//        }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}


