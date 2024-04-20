//
//  AddExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Varshitha Lavu on 4/14/24.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore
import AudioToolbox

protocol ExpenseUpdatedDelegate {
    
    func expenseUpdated() -> Void
}

class AddExpenseViewController: UIViewController {
    
    var delegate: ExpenseUpdatedDelegate?
    
    @IBOutlet weak var categoryBtn: UIButton!
    
    @IBOutlet weak var amountTF: UITextField!
    
    var expense: ExpenseModel?
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add Expense"
        self.setupMenuPopUpButton()
        self.tabBarController?.tabBar.isHidden = true
        amountTF.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    
    func setupMenuPopUpButton() {
        let popUpMenuButtonClosure = { (action: UIAction) in
            print("Pop-up action")
            print(action.title)
            
            self.selectedCategory = action.title
        }
        
        categoryBtn.titleLabel?.text = "Category"
        categoryBtn.menu = UIMenu(children: [
            UIAction(title: "Rent", handler: popUpMenuButtonClosure),
            UIAction(title: "Groceries", handler: popUpMenuButtonClosure),
            UIAction(title: "Transportation", handler: popUpMenuButtonClosure),
            UIAction(title: "Food", handler: popUpMenuButtonClosure),
            UIAction(title: "Stationery", handler: popUpMenuButtonClosure),
            UIAction(title: "Healthcare", handler: popUpMenuButtonClosure),
            UIAction(title: "Entertainment", handler: popUpMenuButtonClosure),
            //UIAction(title: "OTT Subscrption", handler: popUpMenuButtonClosure),
            UIAction(title: "Miscellaneous", handler: popUpMenuButtonClosure)
        ])
        categoryBtn.showsMenuAsPrimaryAction = true
        
        self.selectedCategory = "Rent"
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func add(_ sender: Any) {
        
        if amountTF.text == "" {
            
            self.showAlert(str: "Please enter amount")
            return
        }
        
        let amount = Double(amountTF.text ?? "0") ?? 0
        if amount <= 0 {
            
            self.showAlert(str: "Please enter valid amount")
        }
        
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let previous_expense = self.getCategoryExpense()
        let total = amount + previous_expense
        
        let path = String(format: "%@", "Expenses")
        let db = Firestore.firestore()
        
        let key = self.selectedCategory.replacingOccurrences(of: " ", with: "_")
        
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MM/yyyy"
        let str = dtFormatter.string(from: Date())
        
        let docRef = db.collection(path)
            .whereField("user_id", isEqualTo: id)
            .whereField("date", isEqualTo: str)
        
        // Perform the query
        docRef.getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                self.showAlert(str: error?.localizedDescription ?? "Error fetching documents")
                return
            }
            
            
            if documents.isEmpty {
                
                self.setExpense()
                
            } else {
                let document = documents[0]
                db.collection(path).document(document.documentID).updateData([
                    key: total
                ]) { error in
                    if let error = error {
                        
                        self.showAlert(str: error.localizedDescription)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "", message: "Expense updated successfully", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                            AudioServicesPlaySystemSound(1109)
                            self.delegate?.expenseUpdated()
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func setExpense() -> Void {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MM/yyyy"
        let str = dtFormatter.string(from: Date())
        
        let amount = Double(amountTF.text ?? "0") ?? 0
        if amount <= 0 {
            
            self.showAlert(str: "Please enter valid amount")
        }
        
        let previous_expense = self.getCategoryExpense()
        let total = amount + previous_expense
        
        let params = ["user_id": id,
                      "Rent": self.selectedCategory == "Rent" ? total : 0,
                      "Groceries": self.selectedCategory == "Groceries" ? total : 0,
                      "Transportation": self.selectedCategory == "Transportation" ? total : 0,
                      "Food": self.selectedCategory == "Food" ? total : 0,
                      "Stationery": self.selectedCategory == "Stationery" ? total : 0,
                      "Healthcare": self.selectedCategory == "Healthcare" ? total : 0,
                      "Entertainment": self.selectedCategory == "Entertainment" ? total : 0,
                      "Miscellaneous": self.selectedCategory == "Miscellaneous" ? total : 0,
                      "date": str] as [String : Any]
        
        
        let path = String(format: "%@", "Expenses")
        let db = Firestore.firestore()
        
        db.collection(path).document().setData(params) { err in
            if let err = err {
                self.showAlert(str: err.localizedDescription)
                
            } else {
                let alert = UIAlertController(title: "", message: "Expense updated successfully", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    AudioServicesPlaySystemSound(1109)
                    self.delegate?.expenseUpdated()
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func getCategoryExpense() -> Double {
        
        if self.selectedCategory == "Rent" {
            
            return expense?.Rent ?? 0.0
        }else if self.selectedCategory == "Groceries" {
            
            return expense?.Groceries ?? 0.0
        }else if self.selectedCategory == "Transportation" {
            
            return expense?.Transportation ?? 0.0
        }else if self.selectedCategory == "Food" {
            
            return expense?.Food ?? 0.0
        }else if self.selectedCategory == "Stationery" {
            
            return expense?.Stationery ?? 0.0
        }else if self.selectedCategory == "Healthcare" {
            
            return expense?.Healthcare ?? 0.0
        }else if self.selectedCategory == "Entertainment" {
            
            return expense?.Entertainment ?? 0.0
            
        }else if self.selectedCategory == "Miscellaneous" {
            
            return expense?.Miscellaneous ?? 0.0
        }
        
        return 0.0
    }
}
