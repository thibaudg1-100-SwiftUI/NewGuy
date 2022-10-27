//
//  NameTheGuy.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import SwiftUI

struct NameTheGuy: View {
    
    @Binding var isPresented: Bool
    
    let image: UIImage?
    var wrappedImage: Image {
        if let img = image {
            return Image(uiImage: img)
        }
        
        return Image(systemName: "person.circle.fill")
    }
    
    let onSave: (String) -> Void
    
    @State private var name = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.ultraThinMaterial)
                .opacity(0.75)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button("Cancel", role: .cancel) {
                        isPresented = false
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        onSave(name)
                        isPresented = false
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                TextField("Enter the name", text: $name)
                    .padding()
                    .font(.callout)
                    .background(.white)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                wrappedImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()

        }
    }
}

struct NameTheGuy_Previews: PreviewProvider {
    static var previews: some View {
        NameTheGuy(isPresented: .constant(false), image: UIImage(imageLiteralResourceName: "aldrin"), onSave: {_ in})
    }
}
