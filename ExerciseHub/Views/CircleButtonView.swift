//
//  CircleButtonView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import SwiftUI

struct CircleButtonView: View {
    
    var color: String = "AccentColor2"
    var icon: String
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Color(color)
            Image(systemName: icon).foregroundColor(.white)
        
        }
        .frame(width: size, height: size)
        .cornerRadius(size)
        .padding()
        
    }
    
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(icon: "play.fill", size: 38)
        
    }
    
}
