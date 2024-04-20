//
//  UpdateOrDeleteExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Harchaithanya Kotapati on 4/18/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UpdateOrDeleteExpenseViewController: UIViewController {

    var delegate: ExpenseUpdatedDelegate?
    
    @IBOutlet weak var amountTF: UITextField!
    
    //expense value default to 0 
    var expense = 0.0
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Update Expense"
        self.tabBarController?.tabBar.isHidden = true
        amountTF.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        amountTF.text = String(format: "%0.2f", expense)
    }
    

    @IBAction func update(_ sender: Any) {
        
        if amountTF.text == "" {
            
            self.showAlert(str: "Please enter amount")
            return
        }
        
        let amount = Double(amountTF.text ?? "0") ?? 0
        if amount <= 0 {
            
            self.showAlert(str: "Please enter valid amount")
        }
        
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let key = self.selectedCategory.replacingOccurrences(of: " ", with: "_")
        
        let path = String(format: "%@", "Expenses")
        let db = Firestore.firestore()
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MM/yyyy"
        let str = dtFormatter.string(from: Date())
        
        let query = db.collection(path)
            .whereField("user_id", isEqualTo: id)
            .whereField("date", isEqualTo: str)
        
        // Execute the query
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    // Get the reference to the document
                    let docRef = document.reference
                    
                    // Update the value for the desired key
                    docRef.updateData([
                        key: amount
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            let alert = UIAlertController(title: "", message: "Expense updated successfully", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                                
                                self.delegate?.expenseUpdated()
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func deletes(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this expense?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { action in
            
            self.delete()
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    func delete() -> Void {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let key = self.selectedCategory.replacingOccurrences(of: " ", with: "_")
        
        let path = String(format: "%@", "Expenses")
        let db = Firestore.firestore()
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MM/yyyy"
        let str = dtFormatter.string(from: Date())
        
        let query = db.collection(path)
            .whereField("user_id", isEqualTo: id)
            .whereField("date", isEqualTo: str)
        
        // Execute the query
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    // Get the reference to the document
                    let docRef = document.reference
                    
                    // Update the value for the desired key
                    docRef.updateData([
                        key: 0
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            let alert = UIAlertController(title: "", message: "Expense deleted successfully", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                                
                                self.delegate?.expenseUpdated()
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
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
