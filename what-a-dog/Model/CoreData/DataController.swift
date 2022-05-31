//
//  CoreDataController.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 31/05/22.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BreedModel")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
