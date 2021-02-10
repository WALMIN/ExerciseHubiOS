//
//  PlayButtonView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import SwiftUI

struct PlayButtonView: View {
    
    var color = UIColor(.accentColor)
    var icon = "play.fill"
    var size: CGFloat = 32
    
    var body: some View {
        ZStack {
            Color(color)
            Image(systemName: icon)
                .foregroundColor(.white)
        
        }
        .frame(width: size, height: size)
        .cornerRadius(size)
        .padding()
        
    }
    
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}
