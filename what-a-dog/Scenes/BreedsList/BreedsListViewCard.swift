//
//  BreedsListViewCard.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 17/05/22.
//

import SwiftUI

struct BreedsListViewCard: View {
    @State var nome: String?
    @State var image: Image?

    var body: some View {
        ZStack {
            Image("green_collection_card")
                .resizable()
                .aspectRatio(contentMode: .fit)

            VStack {
                Text(nome ?? "Test")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom)
                (image ?? Image(systemName: "questionmark.circle.fill"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
        }
    }
}

struct BreedsListViewCard_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListViewCard()
    }
}
