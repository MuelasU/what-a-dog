//
//  BreedSelectionCell.swift
//  what-a-dog
//
//  Created by Carolina Zanotto on 23/05/22.
//

import SwiftUI

struct BreedSelectionCell: View {
    @Binding var selectedDog: String?
    let cellName: String
    var breedPercentage: String

    var body: some View {
        HStack {
            if cellName == selectedDog {
                Image(systemName: "checkmark").foregroundColor(Color.Wad.green2)
            } else {
                Image(systemName: "checkmark").foregroundColor(Color.Wad.gray2)
            }
            Text(cellName).foregroundColor(Color.Wad.green2)
            Spacer()
            Text(breedPercentage).foregroundColor(Color.Wad.green2)
                .font(Font.custom("SF Pro Rounded", size: 17))
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
        }
        .padding(.all, 8)
        .listRowBackground(Color.Wad.gray2)
        .onTapGesture {
            self.selectedDog = self.cellName
        }
    }
}
