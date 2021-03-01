//
//  SettingsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    WorkoutView()
                    GeneralView()
                    AboutView()
                    
                }.padding()
                
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing:
                // Close
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                
                }
                                
            )
                
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        
    }
    
}
