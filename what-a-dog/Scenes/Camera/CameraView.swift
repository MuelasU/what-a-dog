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
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                if viewModel.isTaken {
                    UseOrDoNotUseImageButtons(viewModel: viewModel)
                } else {
                    ActionCameraButtons(viewModel: viewModel)
                }
            }
            .padding()
            if viewModel.mustShowImagePicker {
                ImagePickerPreview(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.checkForPermission()
        }
    }
}

struct UseOrDoNotUseImageButtons: View {
    @StateObject var viewModel: CameraViewModel

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "x.circle.fill",
                action: { viewModel.reTakePicture() },
                fontSize: 60
            )
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

struct ActionCameraButtons: View {
    @StateObject var viewModel: CameraViewModel

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
