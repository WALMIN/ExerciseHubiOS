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
            List(workouts) { workout in
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
                
            }
         
            Button(action: {
                addWorkoutAlert("Add a workout", placeholder: "Enter a title", confirm: "Add", cancel: "Cancel")
                
            }) {
                PlayButtonView(icon: "plus")
            
            }
                
        }
        
    }
    
    func addWorkoutAlert(_ title: String, placeholder: String, confirm: String, cancel: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = placeholder
            
        }
        alert.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            if let textField = alert.textFields?.first {
                if let text = textField.text {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        addWorkout(text)
                        
                    }
                    
                }
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
    func addWorkout(_ title: String) {
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.title = title
            
            do {
                try viewContext.save()
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                
            }
            
        }
        
    }
    
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
        
    }
    
}
