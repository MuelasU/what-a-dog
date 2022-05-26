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
            .background(Color("WADbeige1"))
            .foregroundColor(Color("WADgreen2"))
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
            .background(Color("WADbeige1"))
            .foregroundColor(Color("WADgreen2"))
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

struct ARButton: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("logo-apple-ar")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 2))

            Text("See in AR")
                .foregroundColor(Color("WADgreen2"))
                .padding(EdgeInsets(top: 8, leading: 2, bottom: 8, trailing: 16))
        }
        .background(Color("WADgray2"))
        .cornerRadius(10)
    }
}

struct CardView: View {
    var name: String?
    var imageURL: URL?
    var height: String?
    var weight: String?
    var temperament: String?
    var bredFor: String?

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
                        DogCharacteristicsTable(characteristicsValues: [height ?? "",
                                                                        weight ?? "",
                                                                        temperament ?? "",
                                                                        bredFor ?? ""])
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    })
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))

            ARButton()
        }
        .navigationTitle(name ?? "")
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
