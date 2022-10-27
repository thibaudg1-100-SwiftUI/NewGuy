//
//  ContentView.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
   
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.guys) { guy in
                        NavigationLink {
                            GuyDetailView(guy: guy)
                        } label: {
                            GuyRow(guy: guy)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteGuys(at: indexSet)
                    }
                }
                .navigationTitle("NewGuy")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("Add") {
                            viewModel.showPicker = true
                        }
                        
                        Button {
                            viewModel.showCamera = true
                        } label: {
                            Image(systemName: "camera")
                        }
                        .disabled(viewModel.hideCameraButton)
                        // requires a real device with camera to use this feature
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $viewModel.showPicker) {
                    ImagePicker(image: $viewModel.pickedImage)
                }
                .sheet(isPresented: $viewModel.showCamera) {
                    CameraShotPicker(image: $viewModel.pickedImage)
                }
                .onChange(of: viewModel.pickedImage) { _ in
                    viewModel.locationFetcher.start()
                    viewModel.showNameView = true
                }
            }
            
            if viewModel.showNameView {
                NameTheGuy(isPresented: $viewModel.showNameView, image: viewModel.pickedImage) { name in
                    viewModel.addGuy(name: name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
