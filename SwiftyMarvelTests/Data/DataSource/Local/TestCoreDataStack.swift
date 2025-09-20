//
//  TestCoreDataStack.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 03/09/2023.
//

import CoreData
import SwiftyMarvel

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        let container = NSPersistentContainer(name: CoreDataStack.modelName,
                                              managedObjectModel: CoreDataStack.model)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        self.storeContainer = container
    }
}
