//
//  RegisterViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 21/02/2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        
        self.showSpinner(onView: self.view)
        register(email: emailTF.text!, password: passwordTF.text!)
        
    }
    
    
    func register(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: emailTF.text!,
                               password: passwordTF.text!) { authResult, error in
            
            if error != nil {
                
                self.removeSpinner()
                self.showAlert(str: error?.localizedDescription ?? "")
            }else{
                
                let profile = authResult?.user.createProfileChangeRequest()
                profile?.displayName = self.nameTF.text!
                profile?.commitChanges(completion: { error in
                    if error != nil {
                        
                        self.removeSpinner()
                        self.showAlert(str: error?.localizedDescription ?? "")
                    }else{
                        
                        
                        self.setExpense()
                    }
                })
            }
        }
    }
    
    func setExpense() -> Void {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MM/yyyy"
        let str = dtFormatter.string(from: Date())
        
        let params = ["user_id": id,
                      "Rent": 0,
                      "Groceries": 0,
                      "Transportation": 0,
                      "Food": 0,
                      "Stationery": 0,
                      "Healthcare": 0,
                      "Entertainment": 0,
                      "OTT_Subscrption": 0,
                      "Miscellaneous": 0,
                      "date": str] as [String : Any]
        
        
        let path = String(format: "%@", "Expenses")
        let db = Firestore.firestore()
        
        db.collection(path).document().setData(params) { err in
            if let err = err {
                
                self.removeSpinner()
                self.showAlert(str: err.localizedDescription)
                
            } else {
                
                self.removeSpinner()
                self.showAlert(str: "Account created successfully")
            }
        }
    }
    
    
    func showAlert() -> Void {
        
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Account Created successfully", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            
            self.navigationController?.popViewController(animated: true)
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSpinner(onView view: UIView?){
    }
    func removeSpinner(){
    }
}
