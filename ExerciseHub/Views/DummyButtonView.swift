//
//  DummyButtonView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import SwiftUI

struct DummyButtonView: View {
    
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

struct DummyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DummyButtonView()
        
    }
    
}
