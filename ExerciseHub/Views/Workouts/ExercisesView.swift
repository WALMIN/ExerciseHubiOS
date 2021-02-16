//
//  ExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import SwiftUI

struct ExercisesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: false)], animation: .default)
    private var exercises: FetchedResults<Exercise>
    
    var workout: Workout
    
    var body: some View {
        VStack {
            List{
                ForEach(Array(workout.exercises! as Set), id: \.self) { exercise in
                    if let exercise = exercise as? Exercise { 
                        if let name = exercise.name, let exerciseDo = exercise.exerciseDo {
                            ZStack {
                                Color(UIColor(.white))
                                
                                HStack {
                                    VStack {
                                        Text("\(name)")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                            .textCase(.uppercase)
                                            .lineLimit(1)
                                        
                                        Text("\(exerciseDo)")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                        
                                    }
                                        
                                    Spacer()
                                    
                                }.padding(12)
                                
                            }.cornerRadius(8)
                            
                        }
                        
                    }
                    
                }
                
            }.navigationBarTitle("\(workout.title!)")
            
            // Button to add an exercise
            Button(action: {
                addExerciseAlert("Add an exercise", placeholderName: "Enter the exercise name", placeholderDo: "Enter reps/time", confirm: "Add", cancel: "Cancel")
                
            }) {
                PlayButtonView(icon: "plus")
            
            }
            
        }
        
    }
    
    // Alert with 2 textfields to add a exercise
    func addExerciseAlert(_ title: String, placeholderName: String, placeholderDo: String, confirm: String, cancel: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = placeholderName
            
        }
        alert.addTextField() { textField in
            textField.placeholder = placeholderDo
            
        }
        alert.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            if let textFieldName = alert.textFields?[0], let textfieldDo = alert.textFields?[1] {
                if let name = textFieldName.text, let exerciseDo = textfieldDo.text {
                    if !name.trimmingCharacters(in: .whitespaces).isEmpty && !exerciseDo.trimmingCharacters(in: .whitespaces).isEmpty {
                        withAnimation {
                            let newExercise = Exercise(context: viewContext)
                            newExercise.name = name
                            newExercise.exerciseDo = exerciseDo
                            
                            workout.addToExercises(newExercise)
                            
                            do {
                                try viewContext.save()
                                
                            } catch {
                                fatalError("Unresolved error \(error as NSError), \((error as NSError).userInfo)")
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(workout: Workout())
        
    }
    
}
