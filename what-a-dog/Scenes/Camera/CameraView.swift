//
//  CameraView.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var camera = CameraViewModel()

    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                if camera.isTaken {
                    UseOrDoNotUseImageButtons(camera: camera)
                } else {
                    ActionCameraButtons(camera: camera)
                }
            }
            .padding()
        }
        .onAppear {
            camera.checkForPermission()
        }
    }
}

struct UseOrDoNotUseImageButtons: View {
    @StateObject var camera: CameraViewModel

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "x.circle.fill",
                action: { camera.reTakePicture() },
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
    @StateObject var camera: CameraViewModel

    var body: some View {
        HStack {
            Spacer()
            CameraActionButton(
                symbol: "photo.fill",
                action: {},
                fontSize: 40
            )
            Spacer()
            Spacer()
            TakePictureButton(
                action: { camera.takePicture() }
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
