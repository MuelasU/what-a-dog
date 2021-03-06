//
//  CameraViewModel.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var hasSelectedImage = false
    @Published var selectedImage: UIImage!
    @Published var isShowingImagePicker = false
    @Published var classification: [(String, String)]?

    var cameraService: CaptureDevice!

    func injectDependency(device: CaptureDevice) {
        cameraService = device
        cameraService.setCaptureAction { image in
            self.selectedImage = image
            self.hasSelectedImage = true
        }
    }

    func setUpCamera() {
        cameraService.setUp()
    }

    func takePicture() {
        cameraService.takePicture()
    }

    func backFromImagePicker(hasSelectedImage: Bool, image: UIImage?) {
        isShowingImagePicker = false
        self.hasSelectedImage = hasSelectedImage
        selectedImage = image
    }

    func classify() {
        let cgImage = selectedImage.cgImage
        do {
            let breedDetector = try BreedDetector()

            guard let classification = try breedDetector.classify(image: cgImage!) else {
                print("No dog in image")
                return
            }

            guard let formatted = classification.top(3)?.formatted() else {
                print("Error on handling classification")
                return
            }

            print(formatted)
            self.classification = formatted
        } catch {
            print("Error on classifying image")
            return
        }
    }
}
