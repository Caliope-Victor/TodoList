//
//  Persistence.swift
//  TodoList
//
//  Created by Victor Brito on 18/07/22.
//

import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TodoList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// create an activity to core data
    /// - Parameter name: name of activity
    /// - Returns: an activity that was created
    func createActivity(name: String) -> Activity {
        let activity = Activity(context: container.viewContext)
        activity.timestamp = Date()
        activity.name = name
        save()
        return activity
    }
    
    /// update an activity
    /// - Parameters:
    ///   - activity: An activity to be updated
    ///   - name: new name to the actvity
    ///   - timeStamp: new timeStamp
    /// - Returns: the updated activity
    func updateActivity(activity: Activity, name: String, timeStamp: Date? = nil) -> Activity {
        if let timeStamp = timeStamp {
            activity.timestamp = timeStamp
        }
        activity.name = name
        save()
        return activity
    }
    
    /// save the context
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchActivities() -> [Activity] {
        do {
            return try container.viewContext.fetch(Activity.fetchRequest())
        } catch {
            return []
        }
    }
    
    func delete(object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }
    
}
