//
//  CoreDataStack.swift
//  MedicationManager
//
//  Created by Mackenzie Wacker on 12/8/22.
//

import CoreData

// MARK: - Core Data stack

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MedicationManager")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent stroes \(error)")
            }
        }
        return container
    } ()
    
    static var context: NSManagedObjectContext { container.viewContext}
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context \(error)")
            }
        }
    }
}
