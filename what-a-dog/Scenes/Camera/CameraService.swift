//
//  CameraService.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 25/05/22.
//

import AVFoundation
import SwiftUI

protocol CaptureDevice {
    func setCaptureAction(_ captureAction: @escaping (UIImage) -> Void)
    func getView() -> UIView
    func setUp()
    func takePicture()
}

class CameraService: NSObject, AVCapturePhotoCaptureDelegate, CaptureDevice {
    let session = AVCaptureSession()
    let output = AVCapturePhotoOutput()
    var captureAction: ((UIImage) -> Void)!

    func setCaptureAction(_ captureAction: @escaping (UIImage) -> Void) {
        self.captureAction = captureAction
    }

    func getView() -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)
        session.startRunning()
        // FIXME: - Never being stopped
        return view
    }

    func setUp() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            configureCamera()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.configureCamera()
                }
            }
        case .denied:
            print("Acesso negado")
            return
        default:
            return
        }
    }

    private func configureCamera() {
        do {
            session.beginConfiguration()

            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("Device não foi encontrado")
                return
            }
            let input = try AVCaptureDeviceInput(device: device)

            if session.canAddInput(input) {
                session.addInput(input)
            }

            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            session.commitConfiguration()

            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        } catch {
            print("Input da camera não conseguiu ser configurado")
            print(error.localizedDescription)
        }
    }

    func takePicture() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }

    func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error on processing the photo: ", error.localizedDescription)
            return
        }

        guard let cgImage = photo.cgImageRepresentation() else {
            return
        }

        let uiImage = UIImage(
            cgImage: cgImage,
            scale: 1,
            orientation: AccelerometerService.shared.orientation?.toRotatedUIImageOrientation ?? .right
        )
        captureAction(uiImage)
    }
}
