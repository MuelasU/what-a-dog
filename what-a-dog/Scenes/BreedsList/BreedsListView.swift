//
//  BreedsListView.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 16/05/22.
//

import SwiftUI

struct BreedsListView: View {
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach(0 ... 999, id: \.self) { _ in
                    BreedsListViewCard(nome: "Catioro", image: nil)
                }
            }
            .padding([.leading, .trailing])
        }
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
