//
//  PlateView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import SwiftUI

struct PlateView: View {
    
    var title: String = "1"
    var amount: String = "0"
    
    var body: some View {
        VStack {
            ZStack {
                Color("PlateColor")
                Text(title)
            
            }
            .frame(width: 48, height: 48)
            .cornerRadius(48)
         
            Text(amount)
            
        }
            
    }
    
}

struct PlateView_Previews: PreviewProvider {
    static var previews: some View {
        PlateView()
        
    }
    
}
