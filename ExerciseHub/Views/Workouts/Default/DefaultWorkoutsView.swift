//
//  DefaultWorkoutsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import SwiftUI

struct DefaultWorkoutsView: View {
    
    @ObservedObject var fetchWorkouts = FetchWorkouts()
    
    @State private var settingsSheetShowing = false
    @State private var historySheetShowing = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Show no workouts text if the list is empty
                if fetchWorkouts.list.count == 0 {
                    HStack {
                        VStack {
                            Text("No workouts to show").padding()
                            Text("Try again later")
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                // Show workout list
                } else {
                    ScrollView {
                        WarmUpView()
                        
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(fetchWorkouts.list) { workout in
                                NavigationLink(destination: DefaultExercisesView(title: workout.name, description: workout.desc, fetchExercises: FetchExercises(id: workout.id))) {
                                    DefaultWorkoutItemView(workout: workout)
                                    
                                }
                            
                            }
                                
                        }
                        
                    }
                    
                }
                    
            }
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .navigationBarTitle("Default workouts")
            .toolbar {
                // Settings
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { settingsSheetShowing = true }) {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                    
                    }.background(EmptyView().sheet(isPresented: $settingsSheetShowing) { SettingsView() } )
                    
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
    
}

struct DefaultWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultWorkoutsView()
        
    }
    
}
