//
//  WorkoutsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct WorkoutsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Workout.title, ascending: true)], animation: .default)
    private var workouts: FetchedResults<Workout>
    
    var body: some View {
        VStack {
            // Workouts list
            List {
                ForEach(workouts) { workout in
                    Button(action: {
                        
                        
                    }) {
                        ZStack {
                            Color(UIColor(.white))
                            
                            HStack {
                                if let title = workout.title {
                                    Text("\(title)")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .textCase(.uppercase)
                                        .lineLimit(1)
                                }
                                
                                Spacer()
                                
                            }
                            .padding(12)
                            
                        }
                        .cornerRadius(8)
                        
                    }
                    
                }.onDelete(perform: deleteWorkout)
                
                // No workouts text
                if workouts.count == 0 {
                    ZStack {
                        Color(UIColor(.white))
                        
                        HStack {
                            Text("No workouts found")
                                .font(.title3)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .lineLimit(1)
                            
                            Spacer()
                            
                        }
                        .padding(12)
                        
                    }
                    .cornerRadius(8)

                }
                
            }
         
            // Button to add a workout
            Button(action: {
                addWorkoutAlert("Add a workout", placeholder: "Enter a title", confirm: "Add", cancel: "Cancel")
                
            }) {
                PlayButtonView(icon: "plus")
            
            }
                
        }
        
    }
    
    // Alert with textfield to add a workout
    func addWorkoutAlert(_ title: String, placeholder: String, confirm: String, cancel: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = placeholder
            
        }
        alert.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            if let textField = alert.textFields?.first {
                if let text = textField.text {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        withAnimation {
                            let newWorkout = Workout(context: viewContext)
                            newWorkout.title = text
                            
                            do {
                                try viewContext.save()
                                
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
    // Alert to delete a workout
    private func deleteWorkout(offsets: IndexSet) {
        let alert = UIAlertController(title: "Delete a workout", message: "Are you really sure you want to delete this workout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                for index in offsets {
                    let workout = workouts[index]
                    viewContext.delete(workout)
                    
                }
                
                do {
                    try viewContext.save()
                    
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    
                }
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        
        Alert().show(alert)
    
    }
    
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
        
    }
    
}
