//
//  CameraViewModel.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var hasSelectedImage = false

    // TODO: Use this to do classification
    @Published var selectedImage: UIImage! {
        didSet {
            let cgImage = selectedImage.cgImage
            do {
                let breedDetector = try BreedDetector()
                guard let classification = try breedDetector.classify(image: cgImage!)
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

    @Published var isShowingImagePicker = false

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
}
