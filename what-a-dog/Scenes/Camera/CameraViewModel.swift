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
            session.sessionPreset = .photo
            session.commitConfiguration()
        } catch {
            print("Input da camera não conseguiu ser configurado")
            print(error.localizedDescription)
        }
    }

    func takePicture() {
//        let pixelFormatType = output.availableRawPhotoPixelFormatTypes.first!
//        output.capturePhoto(with: AVCapturePhotoSettings(rawPixelFormatType: pixelFormatType), delegate: self)
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)

        DispatchQueue.main.async {
            withAnimation { self.isTaken.toggle() }
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

    // TODO: Usei isso apenas para demosntração, precisa refatorar
    func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        session.stopRunning()

        if let error = error {
            print("Error on processing the photo: ", error.localizedDescription)
            return
        }

        guard let image = photo.cgImageRepresentation() else {
            return
        }

        do {
            let breedDetector = try BreedDetector()
            guard let classification = try breedDetector.classify(image: image)
                .sorted
                .top(5)
            else {
                print("Error on handling classification")
                return
            }

            print(classification.probabilities)
        } catch {
            print("Error on classifying image")
            return
        }
    }
}
