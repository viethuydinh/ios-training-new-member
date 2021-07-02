//
//  Repository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import Foundation
import CoreData

class CoreDataConfiguration {
    
    static let shared = CoreDataConfiguration()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
           
            let container = NSPersistentContainer(name: "Model")
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
                    let error = error as NSError?
                    fatalError("Unresolved error \(String(describing: error)), \(error!.userInfo)")
                }
            }
        }

}

struct CoreDataRepository<Domain: ObjectConvertable> {
    
    func findAll(predicate: NSPredicate? = nil, range: ClosedRange<Int>? = nil, sorts: [NSSortDescriptor]? = nil) -> [Domain] {
        let fetch: NSFetchRequest<Domain.Object> = NSFetchRequest<Domain.Object>(entityName: String(describing: Domain.Object.self))
        fetch.predicate = predicate
        fetch.sortDescriptors = sorts
        if let range = range {
            fetch.fetchOffset = range.lowerBound
            fetch.fetchLimit = range.upperBound - range.lowerBound
        }
        do {
            let results = try CoreDataConfiguration.shared.persistentContainer.viewContext.fetch(fetch)
            return results.map { $0.asDomain }
        } catch {
        print("error")
           return []
        }
    }
    
    func find(id: Domain.ID) -> Domain? {
        self.findAll(predicate: .init(format: "id = %d", argumentArray: [id])).first
    }
    
    // create & update
    func save(domain: Domain) {
        if self.find(id: domain.id) == nil {
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Domain.Object.self), in: CoreDataConfiguration.shared.persistentContainer.viewContext)!
            var object = Domain.Object(entity: entity, insertInto: CoreDataConfiguration.shared.persistentContainer.viewContext)
            object = domain.update(object: object)
            
        } else {
            let fetch: NSFetchRequest<Domain.Object> = NSFetchRequest<Domain.Object>(entityName: String(describing: Domain.Object.self))
            fetch.predicate = .init(format: "id = %d", argumentArray: [domain.id])
            do {
                let results = try CoreDataConfiguration.shared.persistentContainer.viewContext.fetch(fetch)
                results.forEach { (object) in
                    _ = domain.update(object: object)
                }
            } catch {
                print(error)
            }
        }
        
        CoreDataConfiguration.shared.saveContext()
    }
    // create & update
    func saveAll(lists: [Domain]) {
        lists.forEach(self.save(domain:))
    }
    
    func deleteAll(predicate: NSPredicate? = nil, range: ClosedRange<Int>? = nil) {
        let fetch: NSFetchRequest<Domain.Object> = NSFetchRequest<Domain.Object>(entityName: String(describing: Domain.Object.self))
        fetch.predicate = predicate
        if let range = range {
            fetch.fetchOffset = range.lowerBound
            fetch.fetchLimit = range.upperBound - range.lowerBound
        }
        do {
            let results = try CoreDataConfiguration.shared.persistentContainer.viewContext.fetch(fetch)
            results.forEach { (object) in
                CoreDataConfiguration.shared.persistentContainer.viewContext.delete(object)
                CoreDataConfiguration.shared.saveContext()
            }
        } catch {
        print("error")
        }
    }
    
    func delete(id: Domain.ID) {
        self.deleteAll(predicate: .init(format: "id = %d", argumentArray: [id]))
    }
}

