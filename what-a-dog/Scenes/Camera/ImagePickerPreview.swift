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
        return Coordinator(viewModel: _viewModel)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerPreview>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_: UIImagePickerController,
                                context _: UIViewControllerRepresentableContext<ImagePickerPreview>) {}
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @ObservedObject var viewModel: CameraViewModel

    init(viewModel: ObservedObject<CameraViewModel>) {
        _viewModel = viewModel
    }

    func imagePickerController(_: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        viewModel.backFromImagePicker(hasSelectedImage: true, image: unwrapImage)
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        viewModel.backFromImagePicker(hasSelectedImage: false, image: nil)
    }
}
