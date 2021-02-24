//
//  DefaultWorkoutsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import SwiftUI

struct DefaultWorkoutsView: View {
    
    @ObservedObject var fetchWorkouts = FetchWorkouts()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    WarmUpView()
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(fetchWorkouts.list) { item in
                            WorkoutItemView(item: item)
                        
                        }
                            
                    }
                    .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                    
                }
                    
            }.navigationBarTitle("Default workouts")
            
        }
        
    }
    
}

struct DefaultWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultWorkoutsView()
        
    }
    
}
