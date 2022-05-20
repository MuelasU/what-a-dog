//
//  Modal.swift
//  what-a-dog
//
//  Created by Letícia Ferreira Alves on 17/05/22.
//

import SwiftUI

struct Modal: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingSheet: Bool
    @State var selectedItem: String?

    let items: [String] = ["Teckel", "Basset"]

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
                List{
                    ForEach(items, id: \.self) { item in
                        ModalCell(selectedItem: $selectedItem, name: item)
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
            .background(Color("WADgray1"))
            .navigationBarTitle(Text("What a dog?"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
        }
    }
}

struct ModalCell: View {
    @Binding var selectedItem: String?
    let name: String
    var body: some View {
        HStack {
            if name == selectedItem {
                Image(systemName: "checkmark").foregroundColor(Color("WADgreen2"))
            } else {
                Image(systemName: "checkmark").foregroundColor(Color("WADgray2"))
            }
            Text(name).foregroundColor(Color("WADgreen2"))
            Spacer()
            Text("20%").foregroundColor(Color("WADgreen2"))
                .font(Font.custom("SF Pro Rounded", size: 17))
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
        }
        .padding(.all, 8)
        .listRowBackground(Color("WADgray2"))
        .onTapGesture {
            self.selectedItem = self.name
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
            Modal(showingSheet: $showingSheet)
        }
    }
}

struct ModalPreviews: PreviewProvider {
    static var previews: some View {
        Modal(showingSheet: .constant(true))
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
