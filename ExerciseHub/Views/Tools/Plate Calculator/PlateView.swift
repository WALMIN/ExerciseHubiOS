//
//  PlateView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import SwiftUI

struct PlateView: View {
    
    var title: String = "1"
    @State var amount = 0
    
    private let media = MediaUtils()
    
    var body: some View {
        VStack {
            ZStack {
                Color("PlateColor")
                Text(title.replacingOccurrences(of: ".0", with: ""))
            
            }
            .frame(width: 48, height: 48)
            .cornerRadius(48)
         
            Text("\(amount)")
                .font(.caption)
            
        }
        .simultaneousGesture(LongPressGesture().onEnded { _ in
            if amount > 0 {
                amount -= 1
                media.vibrate()
                
            }
                        
        })
        .simultaneousGesture(TapGesture().onEnded {
            amount += 1
            
        })
            
    }
    
}

struct PlateView_Previews: PreviewProvider {
    static var previews: some View {
        PlateView()
        
    }
    
}
