//
//  CameraView.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var viewModel = CameraViewModel()
    @State var selection: Int?

    var body: some View {
        NavigationView {
            ZStack {
                CameraPreview(viewModel: viewModel)
                    .ignoresSafeArea(.all, edges: .all)
                VStack {
                    Spacer()
                    ActionCameraButtons(viewModel: viewModel, selection: $selection)
                }
                .padding()
                .fullScreenCover(isPresented: $viewModel.isShowingImagePicker) {
                    ImagePickerPreview(viewModel: viewModel)
                }
                .fullScreenCover(isPresented: $viewModel.hasSelectedImage) {
                    ConfirmationView(viewModel: viewModel)
                }
            }
            .onAppear {
                viewModel.setUpCamera()
            }
        }
    }
}

struct ActionCameraButtons: View {
    @ObservedObject var viewModel: CameraViewModel
    @Binding var selection: Int?

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "photo.fill",
                action: { viewModel.isShowingImagePicker = true },
                fontSize: 40
            )
            Spacer()
            Spacer()
            TakePictureButton(
                action: { viewModel.takePicture() }
            )
            Spacer()
            Spacer()
            NavigationLink(destination: BreedsListView(), tag: 1, selection: $selection) {
                CameraActionButton(
                    symbol: "square.grid.2x2.fill",
                    action: { selection = 1 },
                    fontSize: 40
                )
            }
            Spacer()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
