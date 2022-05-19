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
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 8) {
                ForEach(viewModel.users) { dog in
                    BreedsListViewCard(nome: dog.name, image: nil)
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
