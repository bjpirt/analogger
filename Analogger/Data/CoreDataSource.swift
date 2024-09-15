//
//  CoreDataSource.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import Combine
import CoreData

class CoreDataSource<T: NSManagedObject>: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private var frc: NSFetchedResultsController<T>
    private var sortKey1: String = "id"
    private var sortKey2: String = "id"
    
    init(entity: NSEntityDescription? = nil) {

        self.entity = entity

        self.frc = NSFetchedResultsController<T>()
        
        super.init()
    }
    
    private var entity: NSEntityDescription? = nil
    
    public func entity(_ entity: NSEntityDescription?) -> CoreDataSource {
        
        self.entity = entity
        return self
    }
    
    public func sortKeys(sortKey1: String?, sortKey2: String?) -> CoreDataSource {
        
        self.sortKey1 = sortKey1 ?? "id"
        self.sortKey2 = sortKey2 ?? "id"
        return self
    }
    
    private func configureFetchRequest() -> NSFetchRequest<T> {
        
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.fetchBatchSize = 0

        if let entity = self.entity {
            fetchRequest.entity = entity
        }
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: self.sortKey1, ascending: true),
            NSSortDescriptor(key: self.sortKey2, ascending: true)
        ]
        
        return fetchRequest
    }
    
    private func configureFetchedResultsController() -> NSFetchedResultsController<T> {
        
        let fetchRequest = self.configureFetchRequest()
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreData.stack.context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        
        return frc
    }
    
    private func performFetch() {
        
        do {
            self.frc = self.configureFetchedResultsController()
            try self.frc.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    public var fetchedObjects: [T] {
        
        return self.frc.fetchedObjects ?? []
    }
    
    public var objects:[T] {
        
        self.performFetch()
        return self.fetchedObjects
    }
    
    public func fetch() -> [T] {
        
        let fetchRequest = self.configureFetchRequest()
        do {
            let objects = try CoreData.stack.context.fetch(fetchRequest)
            return objects
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return [T]()
        }
    }
    
    public var count: Int {
        
        let fetchRequest = self.configureFetchRequest()
        do {
            let count = try CoreData.stack.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return 0
        }
    }
    
    public func delete(from source: IndexSet) {
        
        CoreData.executeBlockAndCommit {
            for index in source {
                CoreData.stack.context.delete(self.fetchedObjects[index])
            }
        }
    }
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        self.objectWillChange.send()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        self.objectWillChange.send()

    }
    
}
