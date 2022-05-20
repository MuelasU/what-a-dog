//
//  BreedsListViewCard.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import SwiftUI

struct BreedsListViewCard: View {
    @State var nome: String?
    @State var imageURL: URL?

    var body: some View {
        Image("card_collection_green")
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
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "questionmark.circle.fill")
                        case let .success(image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                        case .failure:
                            Image(systemName: "questionmark.circle.fill")
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            Image(systemName: "questionmark.circle.fill")
                        }
                    }

//                    (image ?? Image(systemName: "questionmark.circle.fill"))
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding()
                }
            )
            .cornerRadius(20)
    }
}

struct BreedsListViewCard_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListViewCard()
    }
}
