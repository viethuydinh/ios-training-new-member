//
//  BaseFirebase.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 14/08/2021.
//

import Foundation
import Firebase

struct FirebaseRepository<Domain: Codable> {
    static var shared: FirebaseRepository<Domain> {
        return FirebaseRepository()
    }
    
    let db = Firestore.firestore()
    
    private init () {
        
    }
    
    func fetchAll(tableName: String, completion: @escaping(([Domain]) -> ())) -> Bool {
        var error: Int = 0
        var result: [Domain] = []
        let dispatch = DispatchGroup()
        dispatch.enter()
        db.collection(tableName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                error += 1
            } else {
                for document in querySnapshot!.documents {
                    let decoder = JSONDecoder()
                    let dict = document.data()
                    if let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                        let element = try? decoder.decode(Domain.self, from: data)
                        guard let e = element else { return }
                        result.append(e)
                    }
                }
            }
            dispatch.leave()
        }
        dispatch.notify(queue: .main) {
            completion(result)
        }
        
        if error != 0 {
            return false
        } else {
            return true
        }
    }
    
    func save(tableName:String, domain: Domain,id: String, conditionUpdate: [String:Any]) -> Bool {
        var error: Int = 0
        var ref: DocumentReference? = nil
        guard let dict = domain.dictionary else { return false }
        db.collection(tableName).document(id).getDocument { querySnapshot, err in
            if let err = err {
                print("Error adding document: \(err)")
                error += 1
            } else if querySnapshot == nil {
                print("Create")
                ref = db.collection(tableName).addDocument(data: dict) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
            } else {
                print("Update")
                let document = querySnapshot!
                document.reference.updateData(conditionUpdate)
            }
        }
        
        if error != 0 {
            return false
        } else {
            return true
        }
    }
    
    func saveAll(tableName: String, domains: [Domain]) -> Bool {
        var error: Int = 0
        domains.forEach { domain in
            if !self.save(tableName: tableName, domain: domain, id: "", conditionUpdate: [:]) {
                error += 1
            }
        }
        
        if error != 0 {
            return false
        } else {
            return true
        }
    }
    
    func delete(tableName: String,value: String) -> Bool {
        var error: Int = 0
        db.collection(tableName).document(value).delete { err in
            if let err = err {
                print("Error adding document: \(err)")
                error += 1
            } else {
                print("Document delete successfully")
            }
        }
        
        if error != 0 {
            return false
        } else {
            return true
        }
    }
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
