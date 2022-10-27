//
//  ModifyingStateDuringViewUpdate.swift
//  NewGuy
//
//  Created by RqwerKnot on 30/03/2022.
//

import SwiftUI

struct ModifyingStateDuringViewUpdate: View {
    
    @State private var text  = "hello"
    
    var body: some View {
        VStack {
            Text(text)
            TextField("textfield for text", text: $text)
            Button("change text") {
                text = "new text"
            }
        }
    }
}

struct ModifyingStateDuringViewUpdate_Previews: PreviewProvider {
    static var previews: some View {
        ModifyingStateDuringViewUpdate()
    }
}
