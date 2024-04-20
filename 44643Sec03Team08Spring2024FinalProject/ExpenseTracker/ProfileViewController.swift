//
//  ProfileViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 06/03/2024.
//

import UIKit
import FirebaseAuth
import AudioToolbox

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Profile"
        
        
        nameLbl.text = Auth.auth().currentUser?.displayName ?? ""
        emailLbl.text = Auth.auth().currentUser?.email ?? ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func changePassword(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        self.navigationController!.pushViewController(obj, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        AudioServicesPlaySystemSound(1104)
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: { action in

        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in

            self.logout()

        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func logout() -> Void {
        
        do {
            
            try Auth.auth().signOut()
        } catch {}
        
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        self.navigationController!.pushViewController(obj, animated: true)
    }
    
}
