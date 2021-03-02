//
//  SheetUnitSystem.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-02.
//

import SwiftUI

struct SheetUnitSystem: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private let userDefaults = UserDefaults.standard
    
    @State var kgShowing = UserDefaults.standard.bool(forKey: UserDefaultsUtils().kgShowingKey)
    
    var body: some View {
        // Set unit system
        NavigationView {
            HStack {
                Button(action: { kgShowing = true }, label: {
                    Text("KG")
                        .font(.largeTitle)
                        .foregroundColor(kgShowing ? .accentColor : Color(UIColor.label))
                        .fontWeight(kgShowing ? .bold : .none)
                    
                })
                
                Button(action: { kgShowing = false }, label: {
                    Text("LB")
                        .font(.largeTitle)
                        .foregroundColor(!kgShowing ? .accentColor : Color(UIColor.label))
                        .fontWeight(!kgShowing ? .bold : .none)
                    
                })
                
            }
            .fixedSize()
            .padding()
            .navigationTitle("Unit system")
            .navigationBarItems(trailing:
                // Close
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                
                }
                                
            )
            .onDisappear {
                userDefaults.set(kgShowing, forKey: UserDefaultsUtils().kgShowingKey)
                
            }
            
        }
        
    }
    
}

struct SheetUnitSystem_Previews: PreviewProvider {
    static var previews: some View {
        SheetUnitSystem()
        
    }
    
}
