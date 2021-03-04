//
//  MyWorkoutsExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import SwiftUI

struct MyWorkoutsExercisesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: [], animation: .default)
    private var rounds: FetchedResults<Round>
    
    var workout: Workout
    
    @State private var addSheetShowing = false
    @State private var addExerciseShowing = false
    
    var body: some View {
        ScrollView {
            // Exercise list with sections & exercise items with title & reps/time
            LazyVStack {
                // No exercises text
                if workout.roundsArray.count == 0 || workout.roundsArray[0].exercisesArray.count == 0 {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Nothing to show yet").padding()
                            Text("Add an exercise to get started")
                        }
                        Spacer()
                    }
                    
                } else {
                    ForEach(Array(workout.roundsArray.enumerated()), id: \.1) { roundIndex, round in
                        Section(header: HeaderView(workout: workout, roundIndex: roundIndex, round: round) ) {
                            ForEach(Array(round.exercisesArray.enumerated()), id: \.1) { exerciseIndex, exercise in
                                MyWorkoutsExerciseItemView(exercise: exercise)
                                    .contextMenu {
                                        // Delete an exercise button
                                        Button(action: { deleteExercise(roundIndex, exerciseIndex) }) {
                                            Text("Delete")
                                            Image(systemName: "trash")
                                            
                                        }
                                        
                                        // Edit an reps/time button
                                        Button(action: { editExerciseRepsTimeAlert(exercise, roundIndex: roundIndex, title: exercise.wrappedName, textDo: exercise.wrappedExerciseDo) }) {
                                            Text("Edit")
                                            Image(systemName: "pencil")
                                            
                                        }
                                        
                                    }
                                
                            }
                            
                            
                            
                        }
                        .contextMenu {
                            // Delete a round button
                            Button(action: { deleteRound(roundIndex) }) {
                                Text("Delete")
                                Image(systemName: "trash")
                                
                            }
                            
                            // Edit a round button
                            Button(action: { addEditRoundAlert(false, round, title: "Edit a round", textCycles: Int(round.cycles), confirm: "Save") }) {
                                Text("Edit")
                                Image(systemName: "pencil")
                                
                            }
                            
                        }
                    
                    }
                    
                    // Show complete button if there is exercises
                    if workout.roundsArray.count >= 1 {
                        if workout.roundsArray[0].exercisesArray.count >= 1 {
                            Button(action: { addWorkoutToHistory() }) {
                                ZStack {
                                    Color("AccentColor2")
                                    
                                    Text("I've completed this workout")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .textCase(.uppercase)
                                        .padding()
                                    
                                }.cornerRadius(8)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .navigationBarTitle("\(workout.title!)")
            .toolbar(content: {
                // Button to add an item
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { addSheetShowing = true }) {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .padding()
                        
                    }
                    
                }
                
            })
            
        }.actionSheet(isPresented: $addSheetShowing) { () -> ActionSheet in
            ActionSheet(title: Text("Add an item"), message: Text("Select the item you want to add"),
                buttons: [
                    .default(Text("Exercise"), action: { addExerciseShowing = true}),
                    .default(Text("Round"), action: { addEditRoundAlert(true, Round(), title: "Add a round", textCycles: 0, confirm: "Add") }),
                    .destructive(Text("Close"), action: {})
                ]
            )

        }.background(EmptyView().sheet(isPresented: $addExerciseShowing) { SheetAddExercise(workout: workout) })
        
    }
    
    // Alert with textfield to edit time/reps
    func editExerciseRepsTimeAlert(_ exercise: Exercise, roundIndex: Int, title: String, textDo: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.text = textDo
            textField.placeholder = "Enter reps/time"
            
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            if let textFieldDo = alert.textFields?[0] {
                if let exerciseDo = textFieldDo.text{
                    if !exerciseDo.trimmingCharacters(in: .whitespaces).isEmpty {
                        withAnimation {
                            let tempRound = Round(context: viewContext)
                            tempRound.timestamp = Date()
                            tempRound.cycles = 0
                            
                            exercise.exerciseDo = exerciseDo
                            
                            workout.roundsArray[roundIndex].addToExercises(exercise)
                            workout.addToRounds(tempRound)
                            workout.removeFromRounds(tempRound)
                            
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
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
    // Alert to add/edit a round
    private func addEditRoundAlert(_ add: Bool, _ round: Round, title: String, textCycles: Int, confirm: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "Enter amount of cycles"
            
            if !add {
                textField.text = "\(textCycles)"
            }
            
        }
        alert.addAction(UIAlertAction(title: confirm, style: .default) { _ in
            if let textFieldCycles = alert.textFields?[0] {
                if let cycles = textFieldCycles.text {
                    if !cycles.trimmingCharacters(in: .whitespaces).isEmpty && Int16(cycles) ?? 0 > 0{
                        withAnimation {
                            if add {
                                let newRound = Round(context: viewContext)
                                newRound.timestamp = Date()
                                newRound.cycles = Int16(cycles) ?? 1
                                
                                workout.addToRounds(newRound)
                                
                            } else {
                                round.cycles = Int16(cycles) ?? 1
                                
                                workout.addToRounds(round)
                                
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
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
    // Alert to delete an exercise
    private func deleteExercise(_ roundIndex: Int, _ exerciseIndex: Int) {
        let alert = UIAlertController(title: "Delete an exercise", message: "Are you really sure you want to delete this exercise?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                let tempRound = Round(context: viewContext)
                tempRound.timestamp = Date()
                tempRound.cycles = 0
                
                let exercise = workout.roundsArray[roundIndex].exercisesArray[exerciseIndex]
                viewContext.delete(exercise)
                    
                workout.addToRounds(tempRound)
                workout.removeFromRounds(tempRound)
                
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
 
    // Alert to delete a round
    private func deleteRound(_ roundIndex: Int) {
        let alert = UIAlertController(title: "Delete a round", message: "Are you really sure you want to delete the whole round?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                let round = workout.roundsArray[roundIndex]
                workout.removeFromRounds(round)
                viewContext.delete(round)
                    
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
    
    // Alert to save workout to history
    private func addWorkoutToHistory(){
        let alert = UIAlertController(title: "Finish workout", message: "Are you done with the workout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            let newHistory = History(context: viewContext)
            newHistory.timestamp = Date()
            newHistory.title = workout.title
                        
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
                
            } catch {
                fatalError("Unresolved error \(error as NSError), \((error as NSError).userInfo)")
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
}

struct MyWorkoutsExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkoutsExercisesView(workout: Workout())
        
    }
    
}
