//
//  DefaultExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-24.
//

import SwiftUI

struct DefaultExercisesView: View {
    
    var title: String
    @ObservedObject var fetchExercises: FetchExercises
    
    var body: some View {
        VStack {
            // Show no exercises text if the list is empty
            if fetchExercises.list.count == 0 {
                HStack {
                    VStack {
                        Text("No exercises to show").padding()
                        Text("Try again later")
                        
                    }
                    
                }
                
                Spacer()
             
            // Show exercise list with rounds & exercise item
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(fetchExercises.list) { exercise in
                            if exercise.name.starts(with: "|Round") {
                                Text("\(exercise.name.replacingOccurrences(of: "|", with: ""))")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } else if (!exercise.id.contains("2001") && !exercise.id.contains("1979")) {
                                DefaultExerciseItemView(exercise: exercise)
                                
                            }
                        
                        }
                            
                    }
                    .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                    
                }
                
            }
                
        }
        .navigationBarTitle("\(title)")
        
    }
    
}

struct DefaultExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultExercisesView(title: "?", fetchExercises: FetchExercises(id: "0"))
        
    }
    
}
