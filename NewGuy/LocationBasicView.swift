//
//  LocationBasic.swift
//  NewGuy
//
//  Created by RqwerKnot on 29/03/2022.
//

import SwiftUI
import MapKit


struct LocationBasicView: View {
    
    struct Location: Identifiable {
        let id = UUID()
        let center: CLLocationCoordinate2D
    }
    
    let locationFetcher = LocationFetcher()
    
    @State private var latitude = " "
    @State private var longitude = " "
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State private var locations = [Location]()
    
    var body: some View {
        VStack {
            
            // Fast implementation:
            //            Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow))
            
            // Manual implementation 1:
            //            ZStack {
            //                Map(coordinateRegion: $mapRegion)
            //
            //                Circle()
            //                    .fill(.blue.opacity(0.5))
            //                    .frame(width: 12, height: 12)
            //            }
            
            // Manual implementation 2:
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate: location.center, tint: .mint)
            }

            
            Group {
                Button("Start Tracking Location") {
                    self.locationFetcher.start()
                }
                
                Divider()
                
                Button("Read Location") {
                    if let location = self.locationFetcher.lastKnownLocation {
                        print("Your location is \(location)")
                        latitude = "\(location.latitude)"
                        longitude = "\(location.longitude)"
                        
                        // SwiftUI throws a runtime error when updating the mapRegion: [SwiftUI] Modifying state during view update, this will cause undefined behavior.
                        // Use a View Model and a @Published var for the Map Region instead of a local @State variable:
                        mapRegion.center = location // for manual implementation

                        locations = [Location(center: location)]
                        
                    } else {
                        print("Your location is unknown")
                        latitude = "can't read it"
                        longitude = "can't read it"
                    }
                }
                
                Divider()
                
                Text(latitude)
                Text(longitude)
            }
            
        }
    }
}

struct LocationBasic_Previews: PreviewProvider {
    static var previews: some View {
        LocationBasicView()
    }
}
