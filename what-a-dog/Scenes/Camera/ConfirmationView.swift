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
                UseOrDoNotUseImageButton(viewModel: viewModel)
            }
            .padding()
        }
    }
}

struct UseOrDoNotUseImageButton: View {
    @ObservedObject var viewModel: CameraViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "x.circle.fill",
                action: {
                    presentationMode.wrappedValue.dismiss()
                    viewModel.session.startRunning()
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
                action: {},
                fontSize: 60
            )
            Spacer()
        }
    }
}
