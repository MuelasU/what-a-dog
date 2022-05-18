//
//  ImagePicker.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 18/05/22.
//

import SwiftUI

struct ImagePickerPreview: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CameraViewModel

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: _viewModel)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerPreview>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: UIViewControllerRepresentableContext<ImagePickerPreview>) {}
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @ObservedObject var isCoordinatorShown: CameraViewModel

    init(isShown: ObservedObject<CameraViewModel>) {
        _isCoordinatorShown = isShown
    }

    func imagePickerController(_: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        isCoordinatorShown.selectedImage = Image(uiImage: unwrapImage)
        isCoordinatorShown.mustShowImagePicker = false
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        isCoordinatorShown.mustShowImagePicker = false
    }
}
