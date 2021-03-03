//
//  GeneralView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct GeneralView: View {
    
    private let userDefaults = UserDefaults.standard
    
    @State var keepScreenAwake = !UserDefaults.standard.bool(forKey: UserDefaultsUtils().keepScreenAwakeKey)
    @State var vibration = !UserDefaults.standard.bool(forKey: UserDefaultsUtils().vibrationKey)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("General")
                .font(.title3)
                .fontWeight(.bold)
                .fixedSize()
            
            Toggle("Keep screen awake", isOn: $keepScreenAwake)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(EdgeInsets(top: -4, leading: 0, bottom: 0, trailing: 4))
                .onChange(of: keepScreenAwake) { value in
                    userDefaults.set(!value, forKey: UserDefaultsUtils().keepScreenAwakeKey)
                    
                }
            
            Toggle("Vibration", isOn: $vibration)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                .onChange(of: vibration) { value in
                    userDefaults.set(!value, forKey: UserDefaultsUtils().vibrationKey)
                    
                }
            
        }.onDisappear {
            UIApplication.shared.isIdleTimerDisabled = !UserDefaults.standard.bool(forKey: UserDefaultsUtils().keepScreenAwakeKey)
            
        }
        
    }
    
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
        
    }
    
}
