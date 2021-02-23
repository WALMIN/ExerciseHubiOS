//
//  ExerciseItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-22.
//

import SwiftUI

struct ExerciseItemView: View {
    
    let exercise: Exercise
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: [], animation: .default)
    private var rounds: FetchedResults<Round>
    
    @State private var selectedExercise: String? = nil
    
    var body: some View {
        ZStack {
            Color(UIColor(.white))
            
            VStack {
                HStack {
                    Button(action: {
                        if !exercise.custom {
                            selectedExercise = exercise.wrappedName
                        }
                        
                    }) {
                        Image(systemName: exercise.custom ? "rectangle.slash.fill" : "play.rectangle.fill")
                            .foregroundColor(.black)
                    
                    }
                        
                    Text("\(exercise.wrappedName)")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .lineLimit(1)
                    
                    Spacer()
                    
                }
                
                HStack {
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

struct ExerciseItemView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseItemView(exercise: Exercise())
        
    }
    
}
