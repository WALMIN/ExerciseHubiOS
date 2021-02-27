//
//  MyWorkoutsExerciseItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-22.
//

import SwiftUI

struct MyWorkoutsExerciseItemView: View {
    
    let exercise: Exercise
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: [], animation: .default)
    private var rounds: FetchedResults<Round>
    
    @State private var selectedExercise: String? = nil
    
    var body: some View {
        ZStack {
            Color("ItemColor")
            
            VStack {
                HStack {
                    // Show video if it's not a custom exercise
                    Button(action: {
                        if !exercise.custom {
                            selectedExercise = exercise.wrappedName
                        }
                        
                    }) {
                        Image(systemName: exercise.custom ? "rectangle.slash.fill" : "play.rectangle.fill")
                            .foregroundColor(.black)
                    
                    }
                        
                    // Exercise name
                    Text("\(exercise.wrappedName)")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .lineLimit(1)
                    
                    Spacer()
                    
                }
                
                HStack {
                    // Exercise reps/time to do
                    Text("\(exercise.wrappedExerciseDo)")
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

struct MyWorkoutsExerciseItemView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkoutsExerciseItemView(exercise: Exercise())
        
    }
    
}
