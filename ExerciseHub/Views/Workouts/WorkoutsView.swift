//
//  WorkoutsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct WorkoutsView: View {
    
    @ObservedObject var fetchWorkouts = FetchWorkouts()
    
    private let userDefaults = UserDefaults.standard
    
    @State private var currentPage = UserDefaults.standard.integer(forKey: UserDefaultsUtils().workoutsPageKey)
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                // Default workouts page
                DefaultWorkoutsView(fetchWorkouts: fetchWorkouts)
                    .tabItem {
                        Label("Default workouts", systemImage: "square.grid.2x2")
                            
                    }.tag(0)
                    .onAppear { saveCurrentPage(0) }
                
                // My workouts page
                MyWorkoutsView()
                    .tabItem {
                        Label("My workouts", systemImage: "square.and.pencil")
                        
                    }.tag(1)
                    .onAppear { saveCurrentPage(1) }
                
            }
            
        }
        
    }
    
    func saveCurrentPage(_ page: Int){
        userDefaults.set(page, forKey: UserDefaultsUtils().workoutsPageKey)
        
    }
    
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
        
    }
    
}
