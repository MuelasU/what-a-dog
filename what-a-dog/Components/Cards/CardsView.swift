//
//  CardsView.swift
//  what-a-dog
//
//  Created by Fernando Santos on 16/05/22.
//

import SwiftUI

struct CharacteristicsRow: View {
    var characteristic: String?
    var value: String?
    var isMultiline: Bool

    var body: some View {
        if isMultiline {
            VStack {
                HStack {
                    Text(characteristic ?? "")
                        .padding([.leading, .trailing, .top])
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text(String(value ?? ""))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.leading, .trailing, .bottom])
                        .font(.system(size: 18, weight: .medium))
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.Wad.beige1)
            .foregroundColor(Color.Wad.green2)
        } else {
            HStack {
                Text(characteristic ?? "")
                    .padding()
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Text(String(value ?? ""))
                    .padding()
                    .font(.system(size: 18, weight: .medium))
            }
            .background(Color.Wad.beige1)
            .foregroundColor(Color.Wad.green2)
        }
    }
}

struct DogCharacteristicsTable: View {
    let characteristics = ["Height", "Weight", "Temperament", "Bred For"]
    let characteristicsValues: [String]

    var body: some View {
        VStack(spacing: 1) {
            CharacteristicsRow(characteristic: characteristics[0],
                               value: characteristicsValues[0] + " cm",
                               isMultiline: false)
                .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
            CharacteristicsRow(characteristic: characteristics[1],
                               value: characteristicsValues[1] + " kg",
                               isMultiline: false)
            CharacteristicsRow(characteristic: characteristics[2],
                               value: characteristicsValues[2],
                               isMultiline: true)
            CharacteristicsRow(characteristic: characteristics[3],
                               value: characteristicsValues[3],
                               isMultiline: true)
                .cornerRadius(radius: 10, corners: [.bottomLeft, .bottomRight])
        }
    }
}

struct CardView: View {
    var name: String?
    var imageURL: URL?
    var height: String?
    var weight: String?
    var temperament: String?
    var bredFor: String?

    @State var selection: Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Image("card_large")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .overlay(
                    VStack {
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
                        .cornerRadius(10)
                        .padding(16)
                        .clipped()
                        DogCharacteristicsTable(characteristicsValues: [height ?? "N/A",
                                                                        weight ?? "N/A",
                                                                        temperament ?? "N/A",
                                                                        bredFor ?? "N/A"])
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    })
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))

            ARButton(name: name, selection: $selection) {
                selection = 3
            }
        }
        .navigationTitle(name ?? "Name not available")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: NavBackButton(message: "Collection", presentationMode: presentationMode))
    }
}
