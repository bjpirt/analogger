//
//  CoreData.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import CoreData

class CoreData: NSObject {
    
    static let stack = CoreData()   // Singleton
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Analogger")
        container.persistentStoreDescriptions = [
            NSPersistentStoreDescription(url: FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.pirt.analogger.Analogger")!.appendingPathComponent("Analogger.sqlite"))
        ]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        })
        return container
    }()
    
    public var context: NSManagedObjectContext {
        
        get {
            return self.persistentContainer.viewContext
        }
    }
    
    public func save() {
        
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func executeBlockAndCommit(_ block: @escaping () -> Void) {
        
        block()
        CoreData.stack.save()
    }
    
}
