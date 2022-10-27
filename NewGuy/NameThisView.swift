//
//  NameThisView.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import SwiftUI

struct NameThisView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let image: UIImage
    let onSave: (String) -> Void
    
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Guy's name", text: $name)
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(name)
                        
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(image: UIImage, onSave: @escaping (String) -> Void) {
        self.image = image
        self.onSave = onSave
    }
}

struct NameThisView_Previews: PreviewProvider {
    static var previews: some View {
        NameThisView(image: UIImage(), onSave: {_ in})
    }
}
