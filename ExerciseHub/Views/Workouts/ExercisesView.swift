//
//  ExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import SwiftUI

struct ExercisesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: [], animation: .default)
    private var rounds: FetchedResults<Round>
    
    var workout: Workout
    
    @State private var selectedExercise: String? = nil
    @State private var addSheetShowing = false
    
    var body: some View {
        ScrollView {
            // Exercise list with sections & exercise items with title & reps/time
            LazyVStack {
                ForEach(Array(workout.roundsArray.enumerated()), id: \.1) { roundIndex, round in
                    Section(header: Text("Round \(roundIndex + 1)/\(workout.roundsArray.count) - \(round.cycles) cycle(s)")) {
                        ForEach(Array(round.exercisesArray.enumerated()), id: \.1) { exerciseIndex, exercise in
                            ZStack {
                                Color(UIColor(.white))
                                
                                VStack {
                                    HStack {
                                        Button(action: { selectedExercise = exercise.wrappedName }) {
                                            Image(systemName: "play.rectangle.fill")
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
                                        
                                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                                    
                                }.padding(12)
                                
                            }
                            .cornerRadius(8)
                            .contextMenu {
                                // Delete an exercise button
                                Button(action: { deleteExercise(roundIndex, exerciseIndex) }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                    
                                }
                                
                                // Edit an exercise button
                                Button(action: { addEditExerciseAlert(false, exercise, roundIndex: roundIndex, title: "Edit an exercise", textName: exercise.wrappedName, textDo: exercise.wrappedExerciseDo, confirm: "Save") }) {
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
                
                // No exercises text
                if workout.roundsArray.count == 0 {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Nothing to show yet").padding()
                            Text("Edit the workout to get started")
                        }
                        Spacer()
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
            
        }
        .actionSheet(isPresented: $addSheetShowing) { () -> ActionSheet in
            ActionSheet(title: Text("Add an item"), message: Text("Select the item you want to add"),
                buttons: [
                    .default(Text("Exercise"), action: { addEditExerciseAlert(true, Exercise(), roundIndex: (workout.roundsArray.count - 1), title: "Add an exercise", textName: "", textDo: "", confirm: "Add") }),
                    .default(Text("Round"), action: { addEditRoundAlert(true, Round(), title: "Add a round", textCycles: 0, confirm: "Add") }),
                    .destructive(Text("Close"), action: {})

                ]
            )

        }
        .sheet(item: $selectedExercise, content: { selectedExercise in
            SheetVideo(name: selectedExercise)

        })
        
    }
    
    // Alert with 2 textfields to add/edit an exercise
    func addEditExerciseAlert(_ add: Bool, _ exercise: Exercise, roundIndex: Int, title: String, textName: String, textDo: String, confirm: String) {
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
                            let tempRound = Round(context: viewContext)
                            tempRound.timestamp = Date()
                            tempRound.cycles = 0
                            
                            if add {
                                let newExercise = Exercise(context: viewContext)
                                newExercise.timestamp = Date()
                                newExercise.name = name
                                newExercise.exerciseDo = exerciseDo
                                
                                workout.roundsArray[roundIndex].addToExercises(newExercise)
                                
                            } else {
                                exercise.name = name
                                exercise.exerciseDo = exerciseDo
                                
                                workout.roundsArray[roundIndex].addToExercises(exercise)
                            
                            }
                            
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
    
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(workout: Workout())
        
    }
    
}
