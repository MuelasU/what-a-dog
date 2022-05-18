//
//  CameraPreview.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import AVFoundation
import Foundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraViewModel

    func makeUIView(context _: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)

        let preview = AVCaptureVideoPreviewLayer(session: camera.session)
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill

        view.layer.addSublayer(preview)
        camera.session.startRunning()
        return view
    }

    func updateUIView(_: UIView, context _: Context) {}
}
