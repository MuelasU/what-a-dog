//
//  Modal.swift
//  what-a-dog
//
//  Created by Letícia Ferreira Alves on 17/05/22.
//

import SwiftUI

struct BreedSelectionModal: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingSheet: Bool
    @State var selectedItem: String?

    let items: [String] = ["Teckel: 20%", "Basset", "Doberman"]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    Image("card_square")
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10.0)
                        .overlay(
                            Image("dog")
                                .centerCropped()
                                .cornerRadius(10.0)
                                .padding(.all, 24)
                                .clipped()
                        )
                }
                .padding(.all, 16)
                List {
                    ForEach(items, id: \.self) { item in
                        BreedSelectionCell(selectedDog: $selectedItem, cellName: item, breedPercentage: "25%")
                    }
                }
                Spacer()
                WADButton(
                    text: "Add to my collection",
                    icon: Image(systemName: "plus")
                ) {
                    showingSheet.toggle()
                }
            }
            .background(Color.Wad.gray1)
            .navigationBarTitle(Text("What a dog?"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
        }
    }
}

struct ModalView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            BreedSelectionModal(showingSheet: $showingSheet)
        }
    }
}

struct ModalPreviews: PreviewProvider {
    static var previews: some View {
        BreedSelectionModal(showingSheet: .constant(true))
    }
}
