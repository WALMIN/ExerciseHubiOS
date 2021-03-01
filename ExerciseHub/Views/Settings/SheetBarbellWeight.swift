//
//  SheetBarbellWeight.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct SheetBarbellWeight: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private let userDefaults = UserDefaults.standard
    
    @State var kgShowing = UserDefaults.standard.bool(forKey: UserDefaultsUtils().kgShowingKey)
    @State var barbellWeight = 0.0
    
    var body: some View {
        // Enter barbell weight
        Stepper(value: $barbellWeight, in: 0...100, step: 0.10) {
            Text("\(String(format: "%.2f", barbellWeight))")
                .font(.largeTitle)
                
        }
        .padding()
        .onAppear {
            barbellWeight = kgShowing ? userDefaults.double(forKey: UserDefaultsUtils().kgBarbellWeightKey) : userDefaults.double(forKey: UserDefaultsUtils().lbBarbellWeightKey)
            
            if barbellWeight == 0 {
                userDefaults.set(20, forKey: UserDefaultsUtils().kgBarbellWeightKey)
                userDefaults.set(45, forKey: UserDefaultsUtils().lbBarbellWeightKey)
                
                if kgShowing {
                    barbellWeight = 20
                    
                } else {
                    barbellWeight = 45
                    
                }
                
            }
            
        }
        .onDisappear {
            userDefaults.set(barbellWeight, forKey: kgShowing ? UserDefaultsUtils().kgBarbellWeightKey : UserDefaultsUtils().lbBarbellWeightKey)
            
        }
        
    }
    
}

struct SheetBarbellWeight_Previews: PreviewProvider {
    static var previews: some View {
        SheetBarbellWeight()
        
    }
    
}
