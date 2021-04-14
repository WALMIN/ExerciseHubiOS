//
//  ExerciseHubApp.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-01-29.
//

import SwiftUI

@main
struct ExerciseHubApp: App {
    
    private let userDefaults = UserDefaults.standard
    private let persistenceController = PersistenceController.shared
    
    init() {
        //if lastOpenedDate == "" || lastOpenedDate != Utils().dateOnlyFormatter.string(for: Date()) {
            self.userDefaults.set(Utils().dateOnlyFormatter.string(for: Date()), forKey: UserDefaultsUtils().lastOpenedDateKey)
            
            self.userDefaults.set(true, forKey: UserDefaultsUtils().updateWorkoutOfTheDayKey)
            self.userDefaults.set(true, forKey: UserDefaultsUtils().updateExerciseOfTheDayKey)
        
        //}
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        
    }
    
}
