//
//  ExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import SwiftUI

struct ExercisesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [], animation: .default)
    private var exercises: FetchedResults<Exercise>
    
    var workout: Workout

    @State private var editing: Bool = false
    
    var body: some View {
        VStack {
            // Exercise list with title & reps/time
            List{
                ForEach(workout.exercisesArray, id: \.self) { exercise in
                    ZStack {
                        Color(UIColor(.white))
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(exercise.wrappedName)")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .textCase(.uppercase)
                                    .lineLimit(1)
                                
                                Text("\(exercise.wrappedExerciseDo)")
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                
                            }
                                
                            Spacer()
                            
                        }.padding(12)
                        
                    }
                    .cornerRadius(8)
                    .onTapGesture {
                        if editing {
                            addEditExerciseAlert(false, exercise, title: "Edit an exercise", textName: exercise.wrappedName, textDo: exercise.wrappedExerciseDo, confirm: "Save", cancel: "Cancel")
                            
                        }
                        
                    }
                
                }
                .onDelete(perform: editing ? deleteExercise: nil)
                .listRowBackground(Color(UIColor.systemBackground))
                
                // No exercises text
                if workout.exercisesArray.count == 0 {
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
                            addEditExerciseAlert(true, Exercise(), title: "Add an exercise", textName: "", textDo: "", confirm: "Add", cancel: "Cancel")
                            
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
    
    // Alert with 2 textfields to add/edit an exercise
    func addEditExerciseAlert(_ add: Bool, _ exercise: Exercise, title: String, textName: String, textDo: String, confirm: String, cancel: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.text = textName
            textField.placeholder = "Enter the exercise name"
            
        }
        alert.addTextField() { textField in
            textField.text = textDo
            textField.placeholder = "Enter reps/time"
            
        }
        alert.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            if let textFieldName = alert.textFields?[0], let textfieldDo = alert.textFields?[1] {
                if let name = textFieldName.text, let exerciseDo = textfieldDo.text {
                    if !name.trimmingCharacters(in: .whitespaces).isEmpty && !exerciseDo.trimmingCharacters(in: .whitespaces).isEmpty {
                        withAnimation {
                            if add {
                                let newExercise = Exercise(context: viewContext)
                                newExercise.timestamp = Date()
                                newExercise.name = name
                                newExercise.exerciseDo = exerciseDo
                                
                                workout.addToExercises(newExercise)
                                
                            } else {
                                exercise.name = name
                                exercise.exerciseDo = exerciseDo
                                
                                workout.addToExercises(exercise)
                                
                            }
                            
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
    
    // Alert to delete an exercise
    private func deleteExercise(offsets: IndexSet) {
        let alert = UIAlertController(title: "Delete an exercise", message: "Are you really sure you want to delete this exercise?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                for index in offsets {
                    let exercise = workout.exercisesArray[index]
                    viewContext.delete(exercise)
                    
                }
                    
                do {
                    try viewContext.save()
                    
                } catch {
                    fatalError("Unresolved error \(error as NSError), \((error as NSError).userInfo)")
                    
                }
                
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
