//
//  WorkoutView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct WorkoutView: View {
    
    private let userDefaults = UserDefaults.standard
    
    @State var kgShowing = UserDefaults.standard.bool(forKey: UserDefaultsUtils().kgShowingKey)
    
    @State var barbellWeight = 0.0
    
    @State var popoverBarbellWeightShowing = false
    @State var sheetBarbellWeightShowing = false
    
    @State var popoverUnitSystemShowing = false
    @State var sheetUnitSystemShowing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Workout")
                .font(.title3)
                .fontWeight(.bold)
                .fixedSize()
            
            // Show barbell weight popover or sheet
            Button(action: {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    popoverBarbellWeightShowing = true
                    
                } else {
                    sheetBarbellWeightShowing = true
                    
                }
                
            }) {
                Text("Barbell weight")
                    .font(.body)
                    .foregroundColor(Color(UIColor.label))
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                
            }
            .popover(isPresented: $popoverBarbellWeightShowing) { PopoverBarbellWeight() }
            .sheet(isPresented: $sheetBarbellWeightShowing) { SheetBarbellWeight() }
            
            Button(action: {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    popoverUnitSystemShowing = true
                    
                } else {
                    sheetUnitSystemShowing = true
                    
                }
                
            }) {
                Text("Unit system")
                    .font(.body)
                    .foregroundColor(Color(UIColor.label))
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                
            }
            .popover(isPresented: $popoverUnitSystemShowing) { PopoverUnitSystem() }
            .sheet(isPresented: $sheetUnitSystemShowing) { SheetUnitSystem() }
            
        }
        
    }
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
        
    }
    
}
