//
//  GuyRow.swift
//  NewGuy
//
//  Created by RqwerKnot on 28/03/2022.
//

import SwiftUI

struct GuyRow: View {
    
    let guy: Guy    
  
    var body: some View {
        HStack {
            guy.picture
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 44, height: 44)
            
            Text(guy.name)
        }
    }
    
}

struct GuyRow_Previews: PreviewProvider {
    static var previews: some View {
        GuyRow(guy: .exampleGuy)
            .previewLayout(.sizeThatFits)
    }
}
