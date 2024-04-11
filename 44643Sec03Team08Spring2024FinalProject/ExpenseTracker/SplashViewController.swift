//
//  SplashViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 22/02/2024.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        perform(#selector(moveToView), with: nil, afterDelay: 3)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @objc func moveToView() -> Void {
        
        if Auth.auth().currentUser == nil {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBar") as! UITabBarController
            self.navigationController?.pushViewController(vc, animated: true)
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

}

extension UIViewController {
    
    func showAlert(str: String) -> Void {
        
        
        let alert = UIAlertController(title: "", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

