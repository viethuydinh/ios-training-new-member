//
//  BaseCoreData.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 07/07/2021.
//

import Foundation
import CoreData
import UIKit
import RxSwift
import RxCocoa

protocol CoreDataRepo {
    func save<T : ObjectConvertible, V : DomainConvertible>(obj : T, domain : V?)

    func fetchAll<T : ObjectConvertible, V : DomainConvertible>(obj : T?, domain : V?) -> [T]?
    
    func find<T : ObjectConvertible, V : DomainConvertible>(predicate : NSPredicate,obj : T? ,domain : V?) -> V?
}

struct CoreDataConfigure {
    static let shared = CoreDataConfigure()
    
    init() { }

    func configure() -> NSManagedObjectContext {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext()
          }
          let managedContext =
            appDelegate.persistentContainer.viewContext
        return managedContext
    }
}

struct DefaultCoreDataRepo : CoreDataRepo {
    
    static let shared = DefaultCoreDataRepo()
    
    private init() { }
    
    func fetchAll<T, V>(obj: T?, domain: V?) -> [T]? where T : ObjectConvertible, V : DomainConvertible {
        var results : [V]?
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.name)
            results = try CoreDataConfigure.shared.configure().fetch(fetchRequest) as [V]
        } catch let error as NSError {
            NSLog(error.description)
        }
        
        return results!.map { $0.asDomain as! T }
    }
    
    func save<T : ObjectConvertible,V : DomainConvertible>(obj: T ,domain : V?) {
        do {
            var managedContext = CoreDataConfigure.shared.configure()
            guard let entityInsert = NSEntityDescription.entity(forEntityName: T.name , in: managedContext) else {
                return
            }
            var newContext = T.Object(entity: entityInsert, insertInto: managedContext)
            if self.find(predicate: .init(format: "\(obj.primaryKey.first!.key) = %@", argumentArray: [obj.primaryKey.first!.value]), obj: obj, domain: domain) == nil {
                newContext = obj.update(obj: newContext)
                print("create new" )
            }
            else {
                var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.name)
                fetchRequest.predicate = .init(format: "\(obj.primaryKey.first!.key) = %@", argumentArray: [obj.primaryKey.first!.value])
                var results = try managedContext.fetch(fetchRequest)
                results.forEach { (object) in
                    newContext = obj.update(obj: object as! T.Object)
                }
                print("update")
            }
            
            try managedContext.save()
        } catch let error as NSError {
            NSLog(error as! String)
        }
    }
    
    func find<T, V>(predicate: NSPredicate, obj: T?, domain: V?) -> V? where T : ObjectConvertible, V : DomainConvertible {
        var result : V?
        do {
            var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.name)
            fetchRequest.predicate = predicate
            result = try CoreDataConfigure.shared.configure().fetch(fetchRequest).first as? V
        } catch let error as NSError {
            NSLog(error.description)
        }
        
        return result
    }
    
}
