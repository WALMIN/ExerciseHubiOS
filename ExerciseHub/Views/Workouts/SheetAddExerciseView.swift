//
//  SheetAddExerciseView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SheetAddExerciseView: View {
    
    var workout: Workout
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: [], animation: .default)
    private var rounds: FetchedResults<Round>
    
    @State var imageAnimating = true
    
    @State var searchText = ""
    @ObservedObject var fetchLibrary = FetchLibrary()
    
    var body: some View {
        VStack {
            // Show no exercises text if list is empty
            if fetchLibrary.list.count == 0 {
                HStack {
                    VStack {
                        Text("No exercises to show").padding()
                        Text("Try again later")
                        
                    }
                    
                }
                
                Spacer()
                
            // Show textfield and exercise list
            } else {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                        .foregroundColor(.gray)
                    
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search by name...").foregroundColor(.gray)
                            
                        }
                        TextField("", text: $searchText).foregroundColor(.black)
                        
                    }
                    
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .padding(EdgeInsets(top: 14, leading: 14, bottom: 0, trailing: 14))
                
                // Custom exercise
                ZStack {
                    Color(UIColor(.white))
                    HStack {
                        Image("tools")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)

                        Text("Your own exercise")
                            .font(.body)
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                            .lineLimit(1)
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                        
                        Spacer()
                    
                    }
                    .padding(12)
                    
                }
                .cornerRadius(8)
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                .onTapGesture { addExerciseAlert(true, title: "Add an exercise") }
                
                // Exercise list
                ScrollView {
                    LazyVStack {
                        ForEach(fetchLibrary.list.filter({
                            searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                        })) { item in
                            ZStack {
                                Color(UIColor(.white))
                                HStack {
                                    WebImage(url: URL(string: "https://walmin.com/exercisehub/resources/library/gif/\(item.name.lowercased().replacingOccurrences(of: " ", with: "_")).gif"), isAnimating: $imageAnimating)
                                        .placeholder{ Image(systemName: "gobackward").foregroundColor(.black) }
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 44, height: 44)
                                    
                                    Text(item.name)
                                        .font(.body)
                                        .foregroundColor(.accentColor)
                                        .fontWeight(.bold)
                                        .textCase(.uppercase)
                                        .lineLimit(1)
                                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                                    
                                    Spacer()
                                
                                }
                                .padding(12)
                                
                            }
                            .cornerRadius(8)
                            .onTapGesture { addExerciseAlert(false, title: item.name) }
                        
                        }
                            
                    }
                    .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                    
                }
                
            }
            
        }
        
    }
    
    func addExerciseAlert(_ addCustom: Bool, title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        if addCustom {
            alert.addTextField() { textField in
                textField.placeholder = "Enter the exercise name"
                
            }
            
        }
        
        alert.addTextField() { textField in
            textField.placeholder = "Enter reps/time"
            
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            if let textfieldDo = alert.textFields?[addCustom ? 1 : 0] {
                if let exerciseDo = textfieldDo.text {
                    if !exerciseDo.trimmingCharacters(in: .whitespaces).isEmpty {
                        withAnimation {
                            let tempRound = Round(context: viewContext)
                            tempRound.timestamp = Date()
                            tempRound.cycles = 0
                            
                            let newExercise = Exercise(context: viewContext)
                            newExercise.timestamp = Date()
                            
                            if addCustom {
                                if let textFieldName = alert.textFields?[0] {
                                    if let exerciseName = textFieldName.text {
                                        newExercise.name = exerciseName
                                        
                                    }
                                    
                                }
                                
                            } else {
                                newExercise.name = title
                                
                            }
                            newExercise.exerciseDo = exerciseDo
                            newExercise.custom = addCustom
                            
                            workout.roundsArray[workout.roundsArray.count - 1].addToExercises(newExercise)
                                
                            workout.addToRounds(tempRound)
                            workout.removeFromRounds(tempRound)
                            
                            presentationMode.wrappedValue.dismiss()
                            
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
    
    func replaceExercise(_ exercise: Exercise, roundIndex: Int, title: String){
        withAnimation {
            let tempRound = Round(context: viewContext)
            tempRound.timestamp = Date()
            tempRound.cycles = 0
            
            exercise.name = title
            
            workout.roundsArray[roundIndex].addToExercises(exercise)
            workout.addToRounds(tempRound)
            workout.removeFromRounds(tempRound)
            
            presentationMode.wrappedValue.dismiss()
            
            do {
                try viewContext.save()
                
            } catch {
                fatalError("Unresolved error \(error as NSError), \((error as NSError).userInfo)")
                
            }
            
        }
        
    }
    
}

struct SheetAddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        SheetAddExerciseView(workout: Workout())
        
    }
    
}
