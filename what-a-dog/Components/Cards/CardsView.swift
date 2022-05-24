//
//  CardsView.swift
//  what-a-dog
//
//  Created by Fernando Santos on 16/05/22.
//

import SwiftUI

struct DogsStruct {
    let id = UUID()
    let name: String
    let value: Int
}

struct CharacteristicsRow: View {
    var name: String
    var value: Int

    var body: some View {
        HStack {
            Text(name)
                .padding()
                .font(.system(size: 20, weight: .medium))
            Spacer()
            Text(String(value))
                .padding()
                .font(.system(size: 20, weight: .medium))
        }
        .background(Color("WADbeige1"))
        .foregroundColor(Color("WADgreen2"))
    }
}

struct DogCharacteristics: View {
    let dogValues: [DogsStruct]!

    var body: some View {
        VStack(spacing: 1) {
            ForEach(0 ..< 4) { iterator in
                if iterator == 0 {
                    CharacteristicsRow(name: dogValues[iterator].name, value: dogValues[iterator].value)
                        .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
                } else if iterator == 3 {
                    CharacteristicsRow(name: dogValues[iterator].name, value: dogValues[iterator].value)
                        .cornerRadius(radius: 10, corners: [.bottomLeft, .bottomRight])
                } else {
                    CharacteristicsRow(name: dogValues[iterator].name, value: dogValues[iterator].value)
                }
            }
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
    var breedName: String?
    var imageName: String = "largeDog"
    var dogValues = [DogsStruct(name: "Size", value: 2),
                     DogsStruct(name: "Weight", value: 1),
                     DogsStruct(name: "Aggressiveness", value: 16),
                     DogsStruct(name: "Obedience", value: 2)]

    var body: some View {
        VStack {
            Image("card_large")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .overlay(
                    VStack {
                        Image(imageName)
                            .centerCropped()
                            .cornerRadius(10)
                            .padding(16)
                            .clipped()
                        DogCharacteristics(dogValues: dogValues).padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    })
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))

            ARButton()
        }
        .navigationTitle(breedName ?? "")
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
