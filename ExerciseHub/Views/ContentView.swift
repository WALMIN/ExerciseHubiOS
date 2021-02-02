//
//  ContentView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-01-29.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentPage = 1
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                WorkoutsView().tabItem {
                    Image(systemName: "doc.plaintext.fill")
                    Text("Workouts")
                    
                }.tag(1)
                
                LibraryView().tabItem {
                    Image(systemName: "list.triangle")
                    Text("Library")
                    
                }.tag(2)
                
                ToolsView().tabItem {
                    Image(systemName: "")
                    Text("Tools")

                    
                }.tag(3)
                
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
    
}
