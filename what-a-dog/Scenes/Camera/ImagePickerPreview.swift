//
//  ImagePicker.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 18/05/22.
//

import SwiftUI

struct ImagePickerPreview: UIViewControllerRepresentable {
    @Binding var hasSelectedImage: Bool
    @Binding var selectedImage: Image?
    @ObservedObject var viewModel: CameraViewModel

    func makeCoordinator() -> Coordinator {
        return Coordinator(hasSelectedImage: $hasSelectedImage, selectedImage: $selectedImage, isShown: _viewModel)
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
    @Binding var hasSelectedImage: Bool
    @Binding var selectedImage: Image?
    @ObservedObject var isCoordinatorShown: CameraViewModel

    init(hasSelectedImage: Binding<Bool>, selectedImage: Binding<Image?>, isShown: ObservedObject<CameraViewModel>) {
        _hasSelectedImage = hasSelectedImage
        _selectedImage = selectedImage
        _isCoordinatorShown = isShown
    }

    func imagePickerController(_: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        isCoordinatorShown.selectedImage = Image(uiImage: unwrapImage)
        isCoordinatorShown.mustShowImagePicker = false
        isCoordinatorShown.hasSelectedPhoto = true
        selectedImage = Image(uiImage: unwrapImage)
        hasSelectedImage = true
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        isCoordinatorShown.mustShowImagePicker = false
    }
}
