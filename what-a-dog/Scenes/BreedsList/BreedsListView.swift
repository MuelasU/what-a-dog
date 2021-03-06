//
//  BreedsListView.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import Combine
import SwiftUI

struct BreedsListView: View {
    @StateObject var viewModel = BreedListViewModel()
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    // TODO: use this list to show only known breeds
    @FetchRequest(sortDescriptors: []) var knownBreeds: FetchedResults<BreedEntity>

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 8) {
                ForEach(viewModel.dogs) { dog in
                    NavigationLink(destination: CardView(name: dog.name,
                                                         imageURL: URL(string: dog.image?.url ?? "")!,
                                                         height: dog.height?.metric,
                                                         weight: dog.weight?.metric,
                                                         temperament: dog.temperament,
                                                         bredFor: dog.bredFor)) {
                        BreedsListViewCard(name: dog.name, imageURL: URL(string: dog.image?.url ?? "")!)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle("Collection")
        .navigationBarTitleDisplayMode(.large)
    }
}
