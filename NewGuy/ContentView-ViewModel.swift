//
//  ContentView-ViewModel.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import Foundation
import UIKit

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        
        // A collection of newly met guys:
        @Published private(set) var guys: [Guy]
        
        // Show ImagePicker, and the selected UIImage:
        @Published var showPicker = false
        @Published var pickedImage: UIImage?
        
        // Show camera shot picker
        var hideCameraButton: Bool {
            let cameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
            if cameraAvailable {
                let types = UIImagePickerController.availableMediaTypes(for: .camera)
                guard let types = types else {
                    return true
                }
                if types.contains("kUTTypeImage") {
                    return false
                }
            }
            return true
        }
        @Published var showCamera = false
        
        // Show name textfield:
        @Published var showNameView = false
        
        // Path for saving the collection:
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedGuys")
        
        // a location fetcher for matching new import/photo with location:
        let locationFetcher = LocationFetcher()
        
        init() {
            // load collection from Documents storage
            do {
                let data = try Data(contentsOf: savePath)
                self.guys = try JSONDecoder().decode([Guy].self, from: data)
            } catch {
                print("Couldn't retrieve saved collection of Guy. We'll use an empty collection")
                self.guys = []
            }
        }
        
        func addGuy(name: String) {
            // Check that the picked Image is not nil:
            guard let image = pickedImage else {
                print("No image was picked")
                return
            }
            // Check that we are able to get a data container out of the UIImage:
            guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
                print("Couldn't create a data container from a JPEG image")
                return
            }
            
            // Create a new Guy:
            var newGuy = Guy(name: name)
            
            // get the current location:
            if let location = self.locationFetcher.lastKnownLocation {
                print("Your location is \(location)")
                newGuy.latitude = location.latitude
                newGuy.longtitude = location.longitude
            } else {
                print("Your location is unknown")
            }
            
            
            // Compute the path where his picture will be stored
            let imagePath = FileManager.documentsDirectory.appendingPathComponent(newGuy.id.uuidString)
            
            // write image to disk:
            do {
                try jpegData.write(to: imagePath, options: [.atomic, .completeFileProtection])
            } catch {
                print(error.localizedDescription)
            }
            
            // Add the new Guy to the existing collection and sort it:
            self.guys.append(newGuy)
            self.guys.sort()
            
            save()
        }
        
        
        func deleteGuys(at offsets: IndexSet) {
            self.guys.remove(atOffsets: offsets)
            
            save()
        }
        
        func save() {
            // Encode the collection to JSON:
            guard let data = try? JSONEncoder().encode(self.guys) else {
                print("Not able to encode the Guys collection into JSON")
                return
            }
            
            // Save the encoded collection to disk:
            do {
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
}
