//
//  ExpenseModel.swift
//  ExpenseTracker
//
//  Created by Riyaz Hussian on 4/12/24.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
struct ExpenseModel: Codable{
    let id: String
    let user_id: String
    let Rent: Double
    let Groceries: Double
    let Transportation: Double
    let Food: Double
    let Stationery: Double
    let Healthcare: Double
    let Entertainment: Double
    var OTT_Subscrption: Double
    var Miscellaneous: Double
    var date: String
    struct FireStoreOperations{
    }
    
    static let db = Firestore.firestore()
    
    public static func fetchExense(completion: @escaping (ExpenseModel?) -> ()){
        
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MM/yyyy"
        let str = dtFormatter.string(from: Date())
        
        let docRef = db.collection("Expenses")
            .whereField("user_id", isEqualTo: id)
            .whereField("date", isEqualTo: str)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let a = ExpenseModel(id: document.documentID,
                                         user_id: data["user_id"] as? String ?? "",
                                         Rent: data["Rent"] as? Double ?? 0.0,
                                         Groceries: data["Groceries"] as? Double ?? 0.0,
                                         Transportation: data["Transportation"] as? Double ?? 0.0,
                                         Food: data["Food"] as? Double ?? 0.0,
                                         Stationery: data["Stationery"] as? Double ?? 0.0,
                                         Healthcare: data["Healthcare"] as? Double ?? 0.0,
                                         Entertainment: data["Entertainment"] as? Double ?? 0.0,
                                         OTT_Subscrption: data["OTT_Subscrption"] as? Double ?? 0.0,
                                         Miscellaneous: data["Miscellaneous"] as? Double ?? 0.0,
                                         date: data["date"] as? String ?? "")
                    
                    
                    completion(a)
                }
            }
        }
    }
}
