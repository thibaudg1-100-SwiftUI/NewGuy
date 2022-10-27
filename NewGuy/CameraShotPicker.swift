//
//  CameraShotPicker.swift
//  NewGuy
//
//  Created by RqwerKnot on 29/03/2022.
//

import Foundation
import SwiftUI

struct CameraShotPicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: CameraShotPicker
        
        init(_ parent: CameraShotPicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // dismiss the picker following user selection:
            picker.dismiss(animated: true)
            
            guard let mediaType = info[UIImagePickerController.InfoKey.mediaType], mediaType as! String == "kUTTypeImage" else {
                // no media available or it's not a still image:
                return
            }
            
            // Forward up the edited image if it exists, the original image as a fallback, or return as last resort:
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] {
                self.parent.image = editedImage as? UIImage
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] {
                self.parent.image = originalImage as? UIImage
            } else {
                return
            }
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
            if cameraAvailable {
                let types = UIImagePickerController.availableMediaTypes(for: .camera)
                guard let types = types else {
                    // no media type available, return a default UIImagePickerController
                    return UIImagePickerController()
                }
                guard types.contains("kUTTypeImage") else {
                    // no Image media type available, return a default UIImagePickerController
                    return UIImagePickerController()
                }
                // Camera available and able to take a still shot
                
                // create a picker:
                let picker = UIImagePickerController()
                
                // configure the picker:
                picker.sourceType = .camera
                picker.cameraDevice = .rear
                picker.cameraCaptureMode = .photo
                picker.mediaTypes = ["kUTTypeImage"]
                picker.allowsEditing = true
                
                // tell to use the SwiftUI Coordinator for the ViewController delegate:
                picker.delegate = context.coordinator
                
                return picker
            }
        }
        
        // Camera not available on this device, return a default UIImagePickerController:
        return UIImagePickerController()
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
}
