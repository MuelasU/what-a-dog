//
//  CoreDataController.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 31/05/22.
//

import CoreData
import UIKit

class DataController: ObservableObject {
    static let shared = DataController()
    let container = NSPersistentContainer(name: "BreedModel")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func saveBreed(name: String, image: UIImage) {
        let breed = BreedEntity(context: container.viewContext)
        breed.id = UUID()
        breed.name = name
        breed.image = image.pngData()
        try? container.viewContext.save()
    }
}
