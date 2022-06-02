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
    @State var selectedItemIndex: Int = 0
    @State var isShowingDetailView = false
    @State var selectedImage: UIImage
    @State var classificationList: [(String, String)]?

    var body: some View {
        NavigationView {
            VStack {
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

                if let classificationList = classificationList {
                    List {
                        ForEach(classificationList.indices, id: \.self) { indice in
                            BreedSelectionCell(
                                isSelected: selectedItemIndex == indice,
                                cellName: classificationList[indice].0,
                                breedPercentage: classificationList[indice].1,
                                onTap: { selectedItemIndex = indice }
                            )
                        }
                    }

                    Spacer()

                    NavigationLink(destination: BreedsListView(), isActive: $isShowingDetailView) { EmptyView() }
                    WADButton(
                        text: "Add to my collection",
                        icon: Image(systemName: "plus")
                    ) {
                        isShowingDetailView = true
                        DataController.shared.saveBreed(
                            name: classificationList[selectedItemIndex].0,
                            image: selectedImage
                        )
                        print("Saved breed: ", classificationList[selectedItemIndex].0)
                    }
                } else {
                    VStack {
                        Spacer()

                        Text("No dog in image")

                        Spacer()
                    }
                }
            }
            .background(Color.Wad.gray1)
            .navigationTitle("What a dog?")
            .navigationBarBackButtonHidden(false)
        }
    }
}

// struct ModalPreviews: PreviewProvider {
//    static var previews: some View {
//        BreedSelectionModal(showingSheet: .constant(true))
//    }
// }
