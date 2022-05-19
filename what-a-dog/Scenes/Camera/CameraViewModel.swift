//
//  CameraViewModel.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()

    var alert = false
    var output = AVCapturePhotoOutput()

    func checkForPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUpCamera()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUpCamera()
                }
            }
        case .denied:
            alert.toggle()
            return
        default:
            return
        }
    }

    func setUpCamera() {
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
        } catch {
            print("Input da camera não conseguiu ser configurado")
            print(error.localizedDescription)
        }
    }

    func takePicture() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()

            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
            }
        }
    }

    func reTakePicture() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
            }
        }
    }

    // TODO: Enviar essa imagem pro modelo de machine learning
    func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        guard let imageData = photo.fileDataRepresentation() else { return }
    }
}