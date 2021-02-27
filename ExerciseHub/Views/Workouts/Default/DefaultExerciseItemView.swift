//
//  DefaultExerciseItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-24.
//

import SwiftUI

struct DefaultExerciseItemView: View {
    
    let exercise: ExerciseModel
    
    @State private var selectedExercise: String? = nil
    
    var body: some View {
        ZStack {
            Color(UIColor(.white))
            
            VStack {
                HStack {
                    // Show exercise video
                    Button(action: { selectedExercise = exercise.name }) {
                        Image(systemName: "play.rectangle.fill")
                            .foregroundColor(.black)
                    
                    }
                    
                    // Exercise name
                    Text("\(exercise.name)")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .lineLimit(1)
                    
                    Spacer()
                    
                }
                
                HStack {
                    // Exercise reps/time to do
                    Text("\(exercise.exerciseDo)")
                        .font(.caption)
                        .foregroundColor(.black)
                        .lineLimit(1)
                 
                    Spacer()
                    
                }.padding(EdgeInsets(top: 0.5, leading: 0, bottom: 0, trailing: 0))
                
            }.padding(12)
            
        }
        .cornerRadius(8)
        .background(EmptyView().sheet(item: $selectedExercise, content: { selectedExercise in
                SheetVideo(name: selectedExercise)

            })
        
        )
        
    }
    
}

struct DefaultExerciseItemView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultExerciseItemView(exercise: ExerciseModel(id: "0", name: "?", exerciseDo: "?"))
        
    }
    
}
