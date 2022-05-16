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
                .padding()
                .cornerRadius(60)

            VStack(spacing: 1) {
                ForEach(dogValues, id: \.id) { value in
                    HStack {
                        Text(value.name)
                            .padding()
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Text(String(value.value))
                            .padding()
                            .font(.system(size: 20, weight: .medium))
                    }
                    .background(CustomColor.tableColorCard)
                    .foregroundColor(CustomColor.fontColorCard)
                }
            }
            .padding()
        }
        .background(CustomColor.backgroundColorCard)
        .padding()
        .cornerRadius(60)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
