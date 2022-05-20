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
                    HStack {
                        Text(nome ?? "Test")
                            .foregroundColor(.white)
                            .bold()
                            .padding([.leading, .trailing, .top], 8)
                            .lineLimit(1)
                        Spacer()
                    }
                    Spacer()
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "questionmark.circle.fill")
                        case let .success(image):
                            image
                                .centerCropped()

                        case .failure:
                            Image(systemName: "questionmark.circle.fill")
                        @unknown default:
                            Image(systemName: "questionmark.circle.fill")
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(8)
                }
            )
            .cornerRadius(20)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}

struct BreedsListViewCard_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListViewCard()
    }
}
