//
//  ImagePicker.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var image: UIImage?
    @Binding var isShown: Bool
    let callback: () -> Void

    init(image: Binding<UIImage?>, isShown: Binding<Bool>, callback: @escaping () -> Void) {
        _image = image
        _isShown = isShown
        self.callback = callback
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
            callback()
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}


struct ImagePicker: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator

    @Binding var image: UIImage?
    @Binding var isShown: Bool
    let callback: () -> Void

    init(image: Binding<UIImage?>, isShown: Binding<Bool>, sourceType: UIImagePickerController.SourceType, callback: @escaping () -> Void) {
        self._image = image
        self._isShown = isShown
        self.sourceType = sourceType
        self.callback = callback
    }

    var sourceType: UIImagePickerController.SourceType = .camera

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown, callback: callback)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker

    }

}
