//
//  GuyDetailView.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import SwiftUI
import MapKit

struct GuyDetailView: View {
    
    let guy: Guy
    
    @State private var selection = 1
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Picture or Map")) {
                Text("Picture").tag(1)
                Text("Map").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            if selection == 1 {
                ZStack(alignment: .bottomTrailing) {
                    guy.picture
                        .resizable()
                        .scaledToFit()
                    
                    Text(guy.name)
                        .padding(12)
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font((.title))
                        .clipShape(Capsule())
                        .padding([.bottom, .trailing])
                }
            }
            else{
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: guy.location2D, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [guy]) { guy in
                    MapMarker(coordinate: guy.location2D, tint: .mint)
                }
            }
            
            Spacer()
        }
        .navigationTitle(guy.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GuyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GuyDetailView(guy: .exampleGuy)
    }
}
