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
    @State var selection: Int?

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 8) {
                ForEach(viewModel.dogs) { dog in

                    NavigationLink(destination: CardView(breedName: dog.name), tag: 2, selection: $selection) {
                        BreedsListViewCard(nome: dog.name, imageURL: URL(string: dog.image?.url ?? "")!)
                            .onTapGesture {
                                selection = 2
                            }
                    }
                }
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle("Collection")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
