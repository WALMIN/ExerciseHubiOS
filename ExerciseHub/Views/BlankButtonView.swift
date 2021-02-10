//
//  BlankButtonView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import SwiftUI

// Dummy button to just be invisible
struct BlankButtonView: View {
    
    var title = ""
    
    var body: some View {
        Button(action: {}) {
            Text(title)
                .textCase(.uppercase)
                .foregroundColor(Color(UIColor.systemBackground))
                .font(.body)
                .padding()
        }
        
    }
    
}

struct BlankButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BlankButtonView()
        
    }
    
}
