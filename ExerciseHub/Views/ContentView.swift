//
//  ContentView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-01-29.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentPage = 0
    
    init() {
        UIApplication.shared.isIdleTimerDisabled = !UserDefaults.standard.bool(forKey: UserDefaultsUtils().keepScreenAwakeKey)
        
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                WorkoutsView().tabItem {
                    Label("Workouts", systemImage: "doc.plaintext.fill")
                    
                }.tag(0)
                
                LibraryView().tabItem {
                    Label("Library", systemImage: "list.triangle")
                        
                }.tag(1)
                
                ToolsView().tabItem {
                    Label("Tools", image: "tools")
                        
                }.tag(2)
                
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
    
}
