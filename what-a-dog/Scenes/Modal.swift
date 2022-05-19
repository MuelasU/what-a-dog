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

                }.padding(.all, 16)

                List(0 ..< 5) { _ in
                    HStack {
                        Image(systemName: "checkmark").foregroundColor(Color("WADgreen2"))
                        Text("Teckel").foregroundColor(Color("WADgreen2"))
                        Spacer()
                        Text("20%").foregroundColor(Color("WADgreen2"))
                            .font(Font.custom("SF Pro Rounded", size: 17))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.all, 8)
                    .listRowBackground(Color("WADgray2"))
                }
                .padding(.bottom, 8)
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
