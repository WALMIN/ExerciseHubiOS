//
//  ContentView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-01-29.
//

import SwiftUI

struct ContentView: View {
    
    private let userDefaults = UserDefaults.standard
    
    @State private var currentPage = UserDefaults.standard.integer(forKey: UserDefaultsUtils().pageKey)
    
    init() {
        // Clear cache to load in new workouts/exercises
        URLCache.shared.removeAllCachedResponses()
        
        // Set keep screen awake
        UIApplication.shared.isIdleTimerDisabled = !UserDefaults.standard.bool(forKey: UserDefaultsUtils().keepScreenAwakeKey)
        
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                // Home page
                HomeView()
                    .tabItem { Label("Home", systemImage: "house.fill") }
                    .tag(0)
                    .onAppear { saveCurrentPage(0) }
                
                // Workouts page
                WorkoutsView()
                    .tabItem { Label("Workouts", systemImage: "doc.plaintext.fill") }
                    .tag(1)
                    .onAppear { saveCurrentPage(1) }
                
                // Library page
                LibraryView()
                    .tabItem { Label("Library", systemImage: "list.triangle") }
                    .tag(2)
                    .onAppear { saveCurrentPage(2) }
                
                // Tools page
                ToolsView()
                    .tabItem { Label("Tools", image: "tools") }
                    .tag(3)
                    .onAppear { saveCurrentPage(3) }
                
            }
            
        }
        
    }
    
    func saveCurrentPage(_ page: Int){
        userDefaults.set(page, forKey: UserDefaultsUtils().pageKey)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
    
}
