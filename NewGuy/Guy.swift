//
//  Guy.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import Foundation
import SwiftUI
import UIKit
import CoreLocation

struct Guy: Identifiable, Codable, Comparable {
    static func < (lhs: Guy, rhs: Guy) -> Bool {
        lhs.name < rhs.name
    }
    
    var id = UUID() // this ID will serve both for the guy's profile picture ID and Identifiable conformance
    let name: String
    
    var latitude: Double?
    var longtitude: Double?
    var location2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude ?? 0.0, longitude: self.longtitude ?? 0.0)
    }
    
    var picture: Image {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(self.id.uuidString)
        do {
            let data = try Data(contentsOf: savePath)
            guard let uiImage = UIImage(data: data) else { return Image(systemName: "person.circle") }
            return Image(uiImage: uiImage)
        } catch {
            print("Couldn't retrieve picture. We'll use a default picture")
            return Image(systemName: "person.circle")
        }
    }
    
    static let exampleGuy = Guy(name: "Guy")
}
