//
//  SetTimeButtonView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import SwiftUI

struct SetTimeButtonView: View {
    
    var color: String = ""
    var icon: String = ""
    
    var body: some View {
        ZStack {
            Color(color)
            Image(systemName: icon).foregroundColor(.white)
        
        }
        .frame(width: 32, height: 32)
        .cornerRadius(32)
        .padding()
        
    }
    
}

struct SetTimeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeButtonView()
        
    }
    
}
