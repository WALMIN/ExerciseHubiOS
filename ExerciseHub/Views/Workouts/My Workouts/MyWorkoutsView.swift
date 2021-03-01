//
//  MyWorkoutsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import SwiftUI

struct MyWorkoutsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Workout.timestamp, ascending: false)], animation: .default)
    private var workouts: FetchedResults<Workout>
    
    @State private var settingsSheetShowing = false
    @State private var historySheetShowing = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    WarmUpView()
                    
                    // No workouts text
                    if workouts.count == 0 {
                        HStack {
                            Spacer()
                            VStack {
                                Text("No workouts yet").padding()
                                Text("Add one to get started")
                            }
                            Spacer()
                        }
                        
                    } else {
                        // Workouts list
                        LazyVStack {
                            ForEach(Array(workouts.enumerated()), id: \.1) { index, workout in
                                NavigationLink(destination: MyWorkoutsExercisesView(workout: workout)) {
                                    ZStack {
                                        Color("ItemColor")
                                        
                                        HStack {
                                            if let title = workout.title {
                                                Text("\(title)")
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                    .fontWeight(.bold)
                                                    .textCase(.uppercase)
                                                    .lineLimit(1)
                                                    
                                            }
                                            Spacer()
                                            
                                        }.padding(12)
                                        
                                    }.cornerRadius(8)
                                    
                                }.contextMenu {
                                    // Delete workout
                                    Button(action: { deleteWorkout(index: index) }) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                        
                                    }
                                    
                                    // Rename workout
                                    Button(action: { addEditWorkoutAlert(false, workout, title: "Rename the workout", text: workout.title ?? "", confirm: "Save", cancel: "Cancel") }) {
                                        Text("Rename")
                                        Image(systemName: "pencil")
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    
                    }
                    
                }
                    
                
            }
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .navigationBarTitle("My workouts")
            .toolbar {
                // Settings
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { settingsSheetShowing = true }) {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                    
                    }.background(EmptyView().sheet(isPresented: $settingsSheetShowing) { SettingsView() } )
                                
                }
                
                // Button to add a workout
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { addEditWorkoutAlert(true, Workout(), title: "Add a workout", text: "", confirm: "Add", cancel: "Cancel") }) {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                }
                
                // History
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { historySheetShowing = true }) {
                        Image(systemName: "clock.fill")
                            .imageScale(.large)
                    
                    }.background(EmptyView().sheet(isPresented: $historySheetShowing) { HistoryView() } )
                        
                }
                    
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    // Alert with textfield to add/edit a workout
    func addEditWorkoutAlert(_ add: Bool, _ workout: Workout, title: String, text: String, confirm: String, cancel: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.text = text
            textField.placeholder = "Enter a title"
            
        }
        alert.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            if let textField = alert.textFields?.first {
                if let text = textField.text {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        withAnimation {
                            if add {
                                let newWorkout = Workout(context: viewContext)
                                newWorkout.timestamp = Date()
                                newWorkout.title = text
                                
                                let newRound = Round(context: viewContext)
                                newRound.timestamp = Date()
                                newRound.cycles = 3
                                
                                newWorkout.addToRounds(newRound)
                                
                            } else {
                                workout.title = text
                                
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
    
    // Alert to delete a workout
    private func deleteWorkout(index: Int) {
        let alert = UIAlertController(title: "Delete a workout", message: "Are you really sure you want to delete this workout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                let workout = workouts[index]
                viewContext.delete(workout)
                
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

struct MyWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkoutsView()
        
    }
    
}
