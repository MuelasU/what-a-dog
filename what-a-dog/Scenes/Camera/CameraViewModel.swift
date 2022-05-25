//
//  CameraViewModel.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject {
    @Published var hasSelectedImage = false
    @Published var selectedImage: UIImage!
    @Published var mustShowImagePicker = false

    var session = AVCaptureSession()
    var output = AVCapturePhotoOutput()
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
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
            print("Acesso negado")
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
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
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

        selectedImage = UIImage(cgImage: image)
        hasSelectedImage = true

        do {
            let breedDetector = try BreedDetector()
            guard let classification = try breedDetector.classify(image: image)
                .top(5)?
                .formatted(fractionDigits: 2)
            else {
                print("Error on handling classification")
                return
            }

            print(classification)
        } catch {
            print("Error on classifying image")
            return
        }
    }
}
