//
//  PopoverSetTime.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import SwiftUI

struct PopoverSetTime: View {
    
    @Environment(\.presentationMode) var presentationMode
    let userDefaults = UserDefaults.standard
    
    @State var timer = CountdownTimer()
    @State var time = 0.0
    
    var body: some View {
        VStack {
            Text("Set time").font(.title2)
            
            Spacer()
            
            HStack {
                // Remove 1 second if the time is above 0 seconds
                Button(action: { if time > 1 { time -= 1 } }) {
                    CircleButtonView(color: "RemoveColor", icon: "minus", size: 32)
                    
                }
                
                // Show time
                Text(Utils().secondsToHMS(time))
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(width: 128)
                
                // Add 1 second button
                Button(action: { time += 1 }) {
                    CircleButtonView(color: "AddColor", icon: "plus", size: 32)
                    
                }
                
            }
            
            Spacer()
            
            // Save new time & dismiss
            Button(action: {
                timer.timeLeft = time
                presentationMode.wrappedValue.dismiss()
                
                userDefaults.set(time, forKey: UserDefaultsUtils().timerTimeKey)
                
            }) {
                Text("Save")
                
            }
            
        }
        .padding()
        
    }
    
}

struct PopoverSetTime_Previews: PreviewProvider {
    static var previews: some View {
        PopoverSetTime()
        
    }
    
}

