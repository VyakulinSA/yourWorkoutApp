//
//  MockCoreDataStack.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 16.11.2021.
//

import Foundation
import CoreData
@testable import yourWorkoutApp

class MockCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        //Creates an in-memory persistent store.
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        //Creates an NSPersistentContainer instance, passing in the modelName and NSManageObjectModel stored in the CoreDataStack.
        let container = NSPersistentContainer(name: CoreDataStack.modelName,
                                              managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        //Assigns the in-memory persistent store to the container.
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        //Overrides the storeContainer in CoreDataStack.
        storeContainer = container
    }
}
