//
//  AuthenticationFireBase.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 19/08/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol AuthenticationFirebase {
    
    func signIn(email : String, password : String, completion : @escaping(Error?) -> ())
    
    func createUser(email : String, password : String, completion : @escaping(Error?) -> ())
    
    func signOut(completion : @escaping(Error?) -> ())
}

struct DefaultAuthenticationFirebase : AuthenticationFirebase {
    
    static let shared = DefaultAuthenticationFirebase()
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            var errorSignIn : Error?
            if error != nil {
                errorSignIn = ErrorFireBase.invalidCredentials
            }
            else {
                errorSignIn = nil
            }
            completion(errorSignIn)
        }
    }
    
    func createUser(email : String, password : String, completion : @escaping(Error?) ->() ) {
        let dispatchGroup = DispatchGroup()
        var errorAuth : Error?
        dispatchGroup.enter()
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error != nil {
                errorAuth = error
            }
            else {
                Auth.auth().signIn(withEmail: email, password: email)
                errorAuth = nil
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion(errorAuth)
        }
    }
    
    func signOut(completion: @escaping (Error?) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        }
        catch {
            completion(error)
        }
    }
}
