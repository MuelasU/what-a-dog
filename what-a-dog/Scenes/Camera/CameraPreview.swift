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
        guard let cameraService = viewModel.cameraService else { return UIView() }
        return cameraService.getView()
    }

    func updateUIView(_: UIView, context _: Context) {}
}
