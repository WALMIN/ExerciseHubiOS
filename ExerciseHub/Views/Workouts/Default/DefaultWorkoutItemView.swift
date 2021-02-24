//
//  DefaultWorkoutItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DefaultWorkoutItemView: View {
    
    var workout: WorkoutModel
    
    var body: some View {
        ZStack {
            Color(UIColor(.white))
            
            WebImage(url: URL(string: "https://www.walmin.com/exercisehub/resources/workouts/default/thumbnails/d_\(workout.id).jpg"))
                .placeholder{ Image(systemName: "gobackward").foregroundColor(.black) }
                .resizable()
                .scaledToFill()
            
            VStack {
                Spacer()
            
                HStack {
                    Text(workout.name)
                        .font(.caption)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .lineLimit(2)
                    
                    Spacer()
                    
                }.padding(6)
                
            }
            
        }.cornerRadius(8)
        
    }
    
}

struct DefaultWorkoutItemView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultWorkoutItemView(workout: WorkoutModel(id: "0", name: "?", desc: "?"))
        
    }
    
}
