//
//  CardsView.swift
//  what-a-dog
//
//  Created by Fernando Santos on 16/05/22.
//

import SwiftUI

struct DogsCharacteristics {
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
        .background(CustomColor.WADbeige1)
        .foregroundColor(CustomColor.WADgreen2)
    }
}

struct CardView: View {
    let dogValues = [DogsCharacteristics(name: "Size", value: 2),
                     DogsCharacteristics(name: "Weight", value: 1),
                     DogsCharacteristics(name: "Aggressiveness", value: 16),
                     DogsCharacteristics(name: "Obedience", value: 2)]

    var body: some View {
        VStack {
            Image("SausageDog")
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .padding()

            VStack(spacing: 1) {
                ForEach(0 ..< 4) { iterator in
                    if iterator == 0 {
                        CharacteristicsRow(name: dogValues[iterator].name, value: dogValues[iterator].value)
                            .cornerRadius(radius: 8, corners: [.topLeft, .topRight])
                    } else if iterator == 3 {
                        CharacteristicsRow(name: dogValues[iterator].name, value: dogValues[iterator].value)
                            .cornerRadius(radius: 8, corners: [.bottomLeft, .bottomRight])
                    } else {
                        CharacteristicsRow(name: dogValues[iterator].name, value: dogValues[iterator].value)
                    }
                }
            }
            .padding()
        }
        .background(
            // TODO: Teria como fazer isso sem dar scale ?
            Image("card_square")
                .scaleEffect(1.5)
        )
        .cornerRadius(8)
        .padding()
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
