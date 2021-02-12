//
//  ExerciseHubApp.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-01-29.
//

import SwiftUI

@main
struct ExerciseHubApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        
    }
    
}
