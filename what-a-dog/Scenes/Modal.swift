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
        VStack {
            Image("card_square")
                .resizable()
                .scaledToFit()
                .cornerRadius(10.0)
                .padding(.all, 16)

            List(0 ..< 5) { _ in
                HStack {
                    Image(systemName: "checkmark").foregroundColor(Color("WADgreen2"))
                    VStack(alignment: .leading) {
                        Text("Teckel").foregroundColor(Color("WADgreen2"))
                    }
                    Text("20%").foregroundColor(Color("WADgreen2"))
                        .font(Font.custom("SF Pro Rounded", size: 17))
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color("WADgray2"))
                .cornerRadius(10)
            }
            WADButton(
                text: "Add to my collection",
                icon: Image(systemName: "plus")
            ) {
                showingSheet.toggle()
            }
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
            Modal(showingSheet: $showingSheet) // TO DO: adicionar a açao que salva a opçao escolhida na coleçao
        }
    }
}

struct ModalPreviews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
