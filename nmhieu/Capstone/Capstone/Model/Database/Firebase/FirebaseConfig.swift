//
//  FirebaseConfig.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 16/08/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct FirebaseRepository<Domain : ObjectConvertibleFirebase>  {
    
    static var shared: FirebaseRepository<Domain> {
        return FirebaseRepository()
    }
    
    func fetchAll(completion : @escaping ([Domain]? ,Error?) -> ()) {
        var resultsDomain : [Domain]?
        let dispatchGroup = DispatchGroup()
        var errorFireBase : Error?
        dispatchGroup.enter()
        guard Auth.auth().currentUser != nil else { return }
        Firestore.firestore().collection(Domain.name).getDocuments { (query, error) in
            if error != nil {
                errorFireBase = error
            }
            else {
                guard let documents = query?.documents else { return }
                var objects : [Domain.ObjectFirebase] = []
                documents.forEach { document in
                    do {
                        let data = try document.data(as: Domain.ObjectFirebase.self)!
                        objects.append(data)
                        errorFireBase = ErrorFireBase.none
                    }
                    catch {
                        errorFireBase = ErrorFireBase.invalidRequest
                    }
                }
                resultsDomain = objects.map{ $0.asDomain as! Domain }
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(resultsDomain, errorFireBase)
        }
    }
    
    func fetch(documentID : String , completion : @escaping (Domain?, ErrorFireBase) -> ()) {
        var resultDomain : Domain?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        guard Auth.auth().currentUser != nil else { return }
        Firestore.firestore().collection(Domain.name).document(documentID).getDocument { document, error in
            if error != nil {
                completion(.none, ErrorFireBase.timeOut)
            }
            else {
                do {
                    guard let object = try document?.data(as: Domain.ObjectFirebase.self) else { return }
                    resultDomain = (object.asDomain as! Domain)
                }
                catch {
                    
//                    print(error)
                }
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(resultDomain,ErrorFireBase.none)
        }
    }
    
    func fetch(whereFeild : String, isEqualTo : Any, completion : @escaping ([Domain]?, Error?) -> () ) {
        var resultsDomain : [Domain]?
        let dispatchGroup = DispatchGroup()
        var errorFirebase : Error?
        dispatchGroup.enter()
        guard Auth.auth().currentUser != nil else { return }
        Firestore.firestore().collection(Domain.name).whereField(whereFeild, isEqualTo: isEqualTo).getDocuments { (query, error) in
            if error != nil {
                resultsDomain = []
                errorFirebase = error
            }
            else {
                guard let documents = query?.documents else { return }
                var objects : [Domain.ObjectFirebase] = []
                documents.forEach { document in
                    do {
                        let a = try document.data(as: Domain.ObjectFirebase.self)!
                        objects.append(a)
                    }
                    catch {
                        errorFirebase = error
                    }
                }
                resultsDomain = objects.map{ $0.asDomain as! Domain }
                errorFirebase = nil
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion(resultsDomain, errorFirebase)
        }
    }
    
    func fetch(limit : Int, whereFeild : String, isEqualTo : Any, completion : @escaping ([Domain]?, Error?) -> () ) {
        var resultsDomain : [Domain]?
        let dispatchGroup = DispatchGroup()
        var errorFirebase : Error?
        dispatchGroup.enter()
        guard Auth.auth().currentUser != nil else { return }
        Firestore.firestore().collection(Domain.name).limit(to: limit).whereField(whereFeild, isGreaterThanOrEqualTo: isEqualTo).getDocuments { (query, error) in
            if error != nil {
                resultsDomain = []
                errorFirebase = error
            }
            else {
                guard let documents = query?.documents else { return }
                var objects : [Domain.ObjectFirebase] = []
                documents.forEach { document in
                    do {
                        let a = try document.data(as: Domain.ObjectFirebase.self)!
                        objects.append(a)
                    }
                    catch {
                        errorFirebase = error
                    }
                }
                resultsDomain = objects.map{ $0.asDomain as! Domain }
                errorFirebase = nil
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion(resultsDomain, errorFirebase)
        }
    }
    
    func save(domain : Domain, completion : @escaping (Error?) -> ()) {
        let dispatchGroup = DispatchGroup()
        var errorFireBase : Error?
        dispatchGroup.enter()
        guard Auth.auth().currentUser != nil else { return }
        let newContext = domain.asObject()
        do {
            try Firestore.firestore().collection(Domain.name).addDocument(from: newContext)
        }
        catch {
            errorFireBase = ErrorFireBase.invalidRequest
        }
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            completion(errorFireBase)
        }
    }
    
    func update(documentID : String, domain : Domain, completion : @escaping (Error?) -> ()) {
        let dispatchGroup = DispatchGroup()
        var errorFireBase : Error?
        dispatchGroup.enter()
        guard Auth.auth().currentUser != nil else { return }
        let newContext = domain.asObject()
        let document = Firestore.firestore().collection(Domain.name).document(documentID)
        do {
            try document.setData(from: newContext)
        }
        catch {
            errorFireBase = ErrorFireBase.invalidRequest
        }
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            completion(errorFireBase)
        }
    }
    
    func delete(documentID : String, completion : @escaping (Error?) -> ()) {
        guard Auth.auth().currentUser != nil else { return }
        Firestore.firestore().collection(Domain.name).document(documentID).getDocument { response, error in
            if error != nil {
                completion(error)
            }
            else {
                guard let document = response else { return }
                document.reference.delete()
                completion(nil)
            }
        }
    }
    
    func delete(whereField : String, isEqualTo : Any, completion : @escaping (Error?) -> ()) {
        guard Auth.auth().currentUser != nil else { return }
        Firestore.firestore().collection(Domain.name).whereField(whereField, isEqualTo: isEqualTo).getDocuments { response, error in
            if error != nil {
                completion(error)
            }
            else {
                guard let documents = response?.documents else { return }
                documents.forEach { document in
                    document.reference.delete()
                }
                completion(nil)
            }
        }
    }
}
