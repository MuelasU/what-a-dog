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
    @Published var classification = [(String, String)]()

    var cameraService: CaptureDevice!

    func injectDependency(device: CaptureDevice) {
        cameraService = device
        cameraService.setCaptureAction { image in
            self.selectedImage = image
            self.hasSelectedImage = true
            self.classify()
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

    // TODO: Use this to do classification
    func classify() {
        let cgImage = selectedImage.cgImage
        do {
            let breedDetector = try BreedDetector()
            guard let classification = try breedDetector.classify(image: cgImage!)
                .top(3)?
                .formatted(fractionDigits: 2)
            else {
                print("Error on handling classification")
                return
            }

            self.classification = classification
        } catch {
            print("Error on classifying image")
            return
        }
    }
}
