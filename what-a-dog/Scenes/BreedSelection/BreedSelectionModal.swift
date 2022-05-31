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
    @State var isShowingDetailView = false
    @State var selectedImage: UIImage
    @State var classificationList: [(String, String)]!

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
                            Image(uiImage: selectedImage)
                                .centerCropped()
                                .cornerRadius(10.0)
                                .padding(.all, 24)
                                .clipped()
                        )
                }
                .padding(.all, 16)
                List {
                    ForEach(items.indices, id: \.self) { indice in
                        BreedSelectionCell(selectedDog: $selectedItem, cellName: classificationList[indice].0, breedPercentage: classificationList[indice].1)
                    }
                }
                Spacer()
                NavigationLink(destination: BreedsListView(), isActive: $isShowingDetailView) { EmptyView() }
                WADButton(
                    text: "Add to my collection",
                    icon: Image(systemName: "plus")
                ) {
                    isShowingDetailView = true
                }
            }
            .background(Color.Wad.gray1)
            .navigationBarTitle(Text("What a dog?"))
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(false)
        }
    }
}

// struct ModalPreviews: PreviewProvider {
//    static var previews: some View {
//        BreedSelectionModal(showingSheet: .constant(true))
//    }
// }
