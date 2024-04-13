//
//  ExpenseModel.swift
//  ExpenseTracker
//
//  Created by Riyaz Hussian on 4/12/24.
//

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
    
}
