//
//  SettingsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var aboutSheetShowing = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    WorkoutView()
                    GeneralView()
                    
                }.padding()
                
            }
            .navigationTitle("Settings")
            .toolbar {
                // About
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { aboutSheetShowing = true }) {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.large)
                    
                    }.background(EmptyView().sheet(isPresented: $aboutSheetShowing) { SheetAbout() } )
                    
                }
             
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Close
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                    
                    }
                    
                }
                
            }
                
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        
    }
    
}
