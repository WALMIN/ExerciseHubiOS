//
//  ExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import SwiftUI

struct ExercisesView: View {
    
    var workout: Workout
    
    var body: some View {
        Text("\(workout.title!)")
            .font(.body)
            .foregroundColor(Color(UIColor.label))
            .fontWeight(.bold)
            .textCase(.uppercase)
            .lineLimit(1)
        
    }
    
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(workout: Workout())
        
    }
    
}
