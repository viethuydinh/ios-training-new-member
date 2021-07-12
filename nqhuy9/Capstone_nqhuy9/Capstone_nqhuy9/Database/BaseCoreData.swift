//
//  BaseCoreData.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/6/21.
//

import Foundation
import CoreData
import UIKit
import RxSwift
import RxCocoa

class CoreDataConfiguration {
    
    static let shared = CoreDataConfiguration()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
           
            let container = NSPersistentContainer(name: "Capstone_nqhuy9")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let error = error as NSError?
                    fatalError("Unresolved error \(String(describing: error)), \(error!.userInfo)")
                }
            }
        }
    
    func context() -> NSManagedObjectContext {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return .init(concurrencyType: .mainQueueConcurrencyType)
          }
          let managedContext =
            appDelegate.persistentContainer.viewContext
        return managedContext
    }

}

struct CoreDataRepository<Domain : ObjectConvert> {
    
    static var shared : CoreDataRepository<Domain> {
        return CoreDataRepository()
    }
    
    private init() {
        
    }
    
    func fetchAll(predicate: NSPredicate?) -> [Domain] {
        do {
            let fetchRequest = NSFetchRequest<Domain.Object>(entityName: String(describing: Domain.Object.self))
            fetchRequest.predicate = predicate
            let result = try CoreDataConfiguration.shared.context().fetch(fetchRequest)
            return result.map{ $0.asDomain as! Domain }
        } catch let error as NSError {
            NSLog(error.description)
            return []
        }
    }
    
    func fetch(predicate: NSPredicate?) -> Domain? {
        return self.fetchAll(predicate: predicate).first
    }
    
    func save(domain : Domain) {
        let entity = NSEntityDescription.entity(forEntityName: String(describing: Domain.Object.self), in: CoreDataConfiguration.shared.context())!
        var newObject = Domain.Object(entity: entity, insertInto: CoreDataConfiguration.shared.context())
        if self.fetch(predicate: .init(format: "\(domain.key.keys.first!) = %@", argumentArray: [domain.key.values.first!])) == nil {
            newObject = domain.update(object: newObject)
        } else {
            let fetch: NSFetchRequest<Domain.Object> = NSFetchRequest<Domain.Object>(entityName: String(describing: Domain.Object.self))
            fetch.predicate = .init(format: "\(domain.key.keys.first!) = %@", argumentArray: [domain.key.values.first!])
            do {
                let results = try CoreDataConfiguration.shared.context().fetch(fetch)
                results.forEach { (object) in
                    newObject = domain.update(object: object)
                }
            } catch {
                print(error)
            }
        }
        do {
            try CoreDataConfiguration.shared.context().save()
        } catch {
            print("Save Fail")
        }
    }
    
    func saveAll(domains: [Domain]) {
        domains.forEach(self.save(domain:))
    }
    
    func deleteAll(predicate: NSPredicate? = nil) {
        let fetch: NSFetchRequest<Domain.Object> = NSFetchRequest<Domain.Object>(entityName: String(describing: Domain.Object.self))
        fetch.predicate = predicate
        do {
            let results = try CoreDataConfiguration.shared.persistentContainer.viewContext.fetch(fetch)
            results.forEach { (object) in
                CoreDataConfiguration.shared.persistentContainer.viewContext.delete(object)
                CoreDataConfiguration.shared.saveContext()
            }
        } catch {
        print("Delete Fail")
        }
    }
}
