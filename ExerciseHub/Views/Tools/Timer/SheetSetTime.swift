//
//  SheetSetTime.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct SheetSetTime: View {
    
    @Environment(\.presentationMode) var presentationMode
    let userDefaults = UserDefaults.standard
    
    @State var timer = CountdownTimer()
    @State var time = 0.0
    
    var body: some View {
        // Set the time
        NavigationView {
            Stepper(value: $time, in: 0...86400, step: 1) {
                Text(Utils().secondsToHMS(time))
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                    
            }
            .fixedSize()
            .padding()
            .navigationTitle("Set time")
            .navigationBarItems(trailing:
                // Close
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                
                }
                                
            )
            .onDisappear {
                // Save values when the views gets closed
                timer.timeLeft = time
                userDefaults.set(time, forKey: UserDefaultsUtils().timerTimeKey)
                
            }
            
        }
        
    }
    
}

struct SheetSetTime_Previews: PreviewProvider {
    static var previews: some View {
        SheetSetTime()
    }
}
