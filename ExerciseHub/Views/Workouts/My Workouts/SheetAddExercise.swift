//
//  SheetAddExercise.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SheetAddExercise: View {
    
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
            // Show no exercises text if the list is empty
            if fetchLibrary.list.count == 0 {
                HStack {
                    VStack {
                        Text("No exercises to show").padding()
                        Text("Try again later")
                        
                    }
                    
                }
                
                Spacer()
                
            // Show textfield & exercise list
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
                .background(Color("ItemColor"))
                .cornerRadius(8)
                .padding(EdgeInsets(top: 14, leading: 14, bottom: 0, trailing: 14))
                
                // Custom exercise
                ZStack {
                    Color("ItemColor")
                    
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
                                Color("ItemColor")
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
    
    // Alert with textfield(s) to add exercise
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
                            tempRound.cycles = 3
                            
                            let newExercise = Exercise(context: viewContext)
                            newExercise.timestamp = Date()
                            
                            // Add exercise name
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
                            
                            // Check if there is a round already else add one
                            if (workout.roundsArray.count - 1) >= 0 {
                                workout.roundsArray[workout.roundsArray.count - 1].addToExercises(newExercise)
                                
                                workout.addToRounds(tempRound)
                                workout.removeFromRounds(tempRound)
                                
                            }else {
                                workout.addToRounds(tempRound)
                                workout.roundsArray[0].addToExercises(newExercise)
                                
                            }
                            
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
    
}

struct SheetAddExercise_Previews: PreviewProvider {
    static var previews: some View {
        SheetAddExercise(workout: Workout())
        
    }
    
}
