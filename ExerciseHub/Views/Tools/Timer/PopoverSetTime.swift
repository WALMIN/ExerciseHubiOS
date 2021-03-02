//
//  PopoverSetTime.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import SwiftUI

struct PopoverSetTime: View {
    
    let userDefaults = UserDefaults.standard
    
    @State var timer = CountdownTimer()
    @State var time = 0.0
    
    var body: some View {
        // Set the time
        Stepper(value: $time, in: 0...86400, step: 1) {
            Text(Utils().secondsToHMS(time))
                .font(.largeTitle)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                
        }
        .padding()
        .onDisappear {
            // Save values when the views gets closed
            timer.timeLeft = time
            userDefaults.set(time, forKey: UserDefaultsUtils().timerTimeKey)
            
        }
        
    }
    
}

struct PopoverSetTime_Previews: PreviewProvider {
    static var previews: some View {
        PopoverSetTime()
        
    }
    
}

