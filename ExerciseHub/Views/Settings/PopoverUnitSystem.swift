//
//  PopoverUnitSystem.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-02.
//

import SwiftUI

struct PopoverUnitSystem: View {
    
    private let userDefaults = UserDefaults.standard
    
    @State var kgShowing = UserDefaults.standard.bool(forKey: UserDefaultsUtils().kgShowingKey)
    
    var body: some View {
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
        .onDisappear {
            userDefaults.set(kgShowing, forKey: UserDefaultsUtils().kgShowingKey)
            
        }
        
    }
    
}

struct PopoverUnitSystem_Previews: PreviewProvider {
    static var previews: some View {
        PopoverUnitSystem()
        
    }
    
}
