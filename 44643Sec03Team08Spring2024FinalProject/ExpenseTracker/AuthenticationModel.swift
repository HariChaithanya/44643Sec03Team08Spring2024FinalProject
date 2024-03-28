//
//  AuthenticationModel.swift
//  ExpenseTracker
//
//  Created by Harchaithanya Kotapati on 3/28/24.
//

import Foundation
import FirebaseAuth


final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func createUser(email: String, password: String) async throws{
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    
    func signIn(email: String, password: String) async throws{
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
}
