//
//  BaseCoreData.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 07/07/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataConfiguration {
    static let shared = CoreDataConfiguration()
    
    private init() { }

    func configure() -> NSManagedObjectContext {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext()
          }
          let managedContext =
            appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Capstone")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
   func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

struct CoreDataRepository<Domain: ObjectConvertible> {
    
    static var shared: CoreDataRepository<Domain> {
        return CoreDataRepository()
    }
    
    private init() { }
    
    func fetchAll() -> [Domain]? {
        var results : [Domain]?
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Domain.name)
            guard let context = try CoreDataConfiguration.shared.configure().fetch(fetchRequest) as? [Domain.Object] else {
                return []
            }
            print(context)
            results = context.map{ $0.asDomain as! Domain }
        } catch let error as NSError {
            NSLog(error.description)
        }
        return results
    }
    
    func save(domain : Domain) {
        var managedContext = CoreDataConfiguration.shared.configure()
        guard let entityInsert = NSEntityDescription.entity(forEntityName: Domain.name , in: managedContext) else {
            return
        }
        var newContext = Domain.Object(entity: entityInsert, insertInto: managedContext)
        newContext = domain.update(obj: newContext)
        print("create new" )
        CoreDataConfiguration.shared.saveContext()
    }
    
    func fetch(predicate: NSPredicate) -> Domain? {
        var result : Domain?
        do {
            var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Domain.name)
            fetchRequest.predicate = predicate
            guard let context = try CoreDataConfiguration.shared.configure().fetch(fetchRequest).first as? Domain.Object else {
                return nil
            }
            result = context.asDomain as! Domain
        } catch let error as NSError {
            NSLog(error.description)
        }
        return result
    }
    
    func deleteAll() {
        var fetch = NSFetchRequest<NSManagedObject>(entityName: Domain.name)
        do {
            let results = try CoreDataConfiguration.shared.configure().fetch(fetch)
            results.forEach { (object) in
                CoreDataConfiguration.shared.configure().delete(object)
                CoreDataConfiguration.shared.saveContext()
            }
        }
        catch let error as NSError {
            NSLog(error as! String)
        }
    }
    
}
 
