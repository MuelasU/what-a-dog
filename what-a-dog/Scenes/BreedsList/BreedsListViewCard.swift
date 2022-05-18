//
//  BreedsListViewCard.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import SwiftUI

struct BreedsListViewCard: View {
    @State var nome: String?
    @State var image: Image?

    var body: some View {
        Image("green_collection_card")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                VStack {
                    Text(nome ?? "Test")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .lineLimit(1)
                    Spacer()
                    (image ?? Image(systemName: "questionmark.circle.fill"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
            )
    }
}

struct BreedsListViewCard_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListViewCard()
    }
}
