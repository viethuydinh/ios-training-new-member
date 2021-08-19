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
    
    func fetchAll(tableName: String, completion: @escaping(([Domain]) -> ())) {
        var result: [Domain] = []
        let dispatch = DispatchGroup()
        dispatch.enter()
        db.collection(tableName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
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
    }
    
    func save(tableName:String, domain: Domain,id: String, conditionUpdate: [String:Any]) {
        var ref: DocumentReference? = nil
        guard let dict = domain.dictionary else { return }
        db.collection(tableName).document(id).getDocument { querySnapshot, err in
            if let err = err {
                print("Error adding document: \(err)")
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
    }
    
    func saveAll(tableName: String, domains: [Domain]) {
        domains.forEach { domain in
            self.save(tableName: tableName, domain: domain, id: "", conditionUpdate: [:])
        }
    }
    
    func delete(tableName: String,value: String) {
        db.collection(tableName).document(value).delete { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document delete successfully")
            }
        }
    }
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
