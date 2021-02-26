//
//  DefaultExercisesView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-24.
//

import SwiftUI

struct DefaultExercisesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    var title: String
    var description: String
    @ObservedObject var fetchExercises: FetchExercises
    
    var body: some View {
        ScrollView {
            LazyVStack {
                // Show no exercises text if the list is empty
                if fetchExercises.list.count == 0 {
                    HStack {
                        VStack {
                            Text("No exercises to show").padding()
                            Text("Try again later")
                            
                        }
                        
                    }
                    
                    Spacer()
                 
                // Show exercise list with rounds & exercise item
                } else {
                    ForEach(fetchExercises.list) { exercise in
                        if exercise.name.starts(with: "|Round") {
                            Text("\(exercise.name.replacingOccurrences(of: "|", with: ""))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        } else if (!exercise.id.contains("2001") && !exercise.id.contains("1979")) {
                            DefaultExerciseItemView(exercise: exercise)
                            
                        }
                    
                    }
                    
                    Button(action: {
                        addWorkoutToHistory()
                        
                    }) {
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
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .navigationBarTitle("\(title)")
            .navigationBarItems(trailing:
                // Button to show workout info
                Button(action: { infoAlert(title, description) }) {
                    Image(systemName: "info.circle.fill")
                        .imageScale(.large)
                
                }
                                
            )
            
        }
       
        
    }
    
    // Alert to save workout to history
    private func addWorkoutToHistory(){
        let alert = UIAlertController(title: "Finish workout", message: "Are you done with the workout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            let newHistory = History(context: viewContext)
            newHistory.timestamp = Date()
            newHistory.title = title
                        
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
    
    private func infoAlert(_ title: String, _ description: String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default) { _ in })
        
        Alert().show(alert)
        
    }
    
}

struct DefaultExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultExercisesView(title: "?", description: "?", fetchExercises: FetchExercises(id: "0"))
        
    }
    
}
