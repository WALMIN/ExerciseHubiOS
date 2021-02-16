//
//  ExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import SwiftUI

struct ExercisesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.timestamp, ascending: true)], animation: .default)
    private var exercises: FetchedResults<Exercise>
    
    var workout: Workout

    @State private var editing: Bool = false
    
    var body: some View {
        VStack {
            // Exercise list with title & reps/time
            List{
                ForEach(Array(workout.exercises! as Set), id: \.self) { exercise in
                    if let exercise = exercise as? Exercise { 
                        if let name = exercise.name, let exerciseDo = exercise.exerciseDo {
                            ZStack {
                                Color(UIColor(.white))
                                
                                HStack {
                                    VStack(alignment: .leading) {
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
                .onDelete(perform: editing ? deleteExercise: nil)
                .listRowBackground(Color(UIColor.systemBackground))
                
                // No exercises text
                if workout.exercises!.count == 0 {
                    HStack {
                        Spacer()
                        Text("No exercises yet").padding()
                        Spacer()
                    }.listRowBackground(Color(UIColor.systemBackground))
                    
                }
                
            }
            .navigationBarTitle("\(workout.title!)")
            .toolbar(content: {
                // Button to add an exercise if currently editing
                ToolbarItem(placement: .navigationBarTrailing) {
                    if editing {
                        Button(action: {
                            addExerciseAlert("Add an exercise", placeholderName: "Enter the exercise name", placeholderDo: "Enter reps/time", confirm: "Add", cancel: "Cancel")
                            
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .padding()
                            
                        }
                        
                    }
                    
                }
                
                // Edit button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editing.toggle()
                        
                    }) {
                        Image(systemName: editing ? "checkmark.circle.fill" : "pencil.circle.fill")
                            .imageScale(.large)
                        
                    }
                    
                }
                
            })
            
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
                            newExercise.timestamp = Date()
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
    
    // Move an exercise/round
    private func moveExercise() {
        
        
    }
    
    // Alert to delete an exercise
    private func deleteExercise(offsets: IndexSet) {
        let alert = UIAlertController(title: "Delete an exercise", message: "Are you really sure you want to delete this exercise?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                /*
                for index in offsets {
                    let exercise = workout.exercises
                    viewContext.delete(exercise)
                    
                }
                    
                do {
                    try viewContext.save()
                    
                } catch {
                    fatalError("Unresolved error \(error as NSError), \((error as NSError).userInfo)")
                    
                }
                 */
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        
        Alert().show(alert)
    
    }
    
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(workout: Workout())
        
    }
    
}
