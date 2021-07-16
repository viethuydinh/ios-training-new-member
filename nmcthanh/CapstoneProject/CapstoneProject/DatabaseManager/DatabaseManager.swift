//
//  DatabaseManager.swift
//  CapstoneProject
//
//  Created by Thuy on 7/16/21.
//

import UIKit
import CoreData


class DBManager {
    static let share = DBManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CapstoneProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAuthen() -> [Authentication]
    {
        var authen = [Authentication]()
        let fetchRequest = Authentication.fetchRequest() as NSFetchRequest<Authentication>

        do
        {
            authen = try context.fetch(fetchRequest)
        } catch {
            print("Some error occured when fetching the products")
        }
        
        return authen
    }
    
}



