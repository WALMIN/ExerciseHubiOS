//
//  WorkoutsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct WorkoutsView: View {
    
    @State var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                DefaultWorkoutsView().tabItem {
                    Label("Default workouts", systemImage: "square.grid.2x2")
                        
                }.tag(0)
                
                MyWorkoutsView().tabItem {
                    Label("My workouts", systemImage: "square.and.pencil")
                    
                }.tag(1)
                
            }
            
        }
        
    }
    
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
        
    }
    
}
