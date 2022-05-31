//
//  CoreDataTestView.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 31/05/22.
//

import SwiftUI

// TODO: remover essa classe
struct CoreDataTestView: View {
    @FetchRequest(sortDescriptors: []) var breeds: FetchedResults<BreedEntity>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
            Button("Nova raça") {
                let names = ["vira-lata", "basset", "pastor alemao", "dobberman", "pitbull"]
                let name = names.randomElement()!
                let breed = BreedEntity(context: moc)
                breed.id = UUID()
                breed.name = name
                try? moc.save()
            }
            List(breeds) { breed in
                Text(breed.name ?? "Unknown")
            }
        }
    }
}
