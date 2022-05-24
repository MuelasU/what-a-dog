//
//  CameraView.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var viewModel = CameraViewModel()

    var body: some View {
        ZStack {
            CameraPreview(viewModel: viewModel)
            VStack {
                Spacer()
                ActionCameraButtons(viewModel: viewModel)
            }
            .padding()
            .fullScreenCover(isPresented: $viewModel.mustShowImagePicker) {
                ImagePickerPreview(viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $viewModel.hasSelectedImage) {
                ConfirmationView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.checkForPermission()
        }
    }
}

struct ActionCameraButtons: View {
    @ObservedObject var viewModel: CameraViewModel

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "photo.fill",
                action: { viewModel.mustShowImagePicker = true },
                fontSize: 40
            )
            Spacer()
            Spacer()
            TakePictureButton(
                action: { viewModel.takePicture() }
            )
            Spacer()
            Spacer()
            CameraActionButton(
                symbol: "square.grid.2x2.fill",
                action: {},
                fontSize: 40
            )
            Spacer()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
