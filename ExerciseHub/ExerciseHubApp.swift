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
    private var lastOpenedDate = UserDefaults.standard.string(forKey: UserDefaultsUtils().lastOpenedDateKey)
    
    private let persistenceController = PersistenceController.shared
    
    init() {
        // If new day, get new workout & exercise of the day
        if lastOpenedDate == "" || lastOpenedDate != Utils().dateOnlyFormatter.string(for: Date()) {
            self.userDefaults.set(Utils().dateOnlyFormatter.string(for: Date()), forKey: UserDefaultsUtils().lastOpenedDateKey)
            
            self.userDefaults.set(true, forKey: UserDefaultsUtils().updateWorkoutOfTheDayKey)
            self.userDefaults.set(true, forKey: UserDefaultsUtils().updateExerciseOfTheDayKey)
        
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        
    }
    
}
