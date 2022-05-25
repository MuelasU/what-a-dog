//
//  CameraPreview.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var viewModel: CameraViewModel

    func makeUIView(context _: Context) -> UIView {
        viewModel.injectDependency(device: CameraService())
        if let cameraService = viewModel.cameraService {
            return cameraService.getView()
        }
        return UIView()
    }

    func updateUIView(_: UIView, context _: Context) {}
}
