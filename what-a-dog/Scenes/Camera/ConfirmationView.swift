//
//  ConfirmationView.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 23/05/22.
//

import SwiftUI

struct ConfirmationView: View {
    @ObservedObject var viewModel: CameraViewModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Image(uiImage: viewModel.selectedImage)
                .resizable()
                .scaledToFit()
            VStack {
                Spacer()
                ConfirmationButtons(viewModel: viewModel)
            }
            .padding()
        }
    }
}

struct ConfirmationButtons: View {
    @ObservedObject var viewModel: CameraViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "x.circle.fill",
                action: {
                    presentationMode.wrappedValue.dismiss()
                },
                fontSize: 60
            )
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            CameraActionButton(
                symbol: "checkmark.circle.fill",
                action: {
                    showingSheet.toggle()
                },
                fontSize: 60
            )
            .sheet(isPresented: $showingSheet) {
                BreedSelectionModal(showingSheet: $showingSheet, selectedImage: viewModel.selectedImage)
            }
            Spacer()
        }
    }
}
