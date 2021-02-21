//
//  CountdownTimer.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import Foundation

class CountdownTimer: ObservableObject {
    
    @Published var state: CountdownTimerStates = .stopped
    @Published var timeLeft: Double = UserDefaults.standard.double(forKey: UserDefaultsUtils().timerTimeKey)
    private var timer = Timer()
    private let media = MediaUtils()
    
    init() {
        if timeLeft == 0 {
            UserDefaults.standard.set(60, forKey: UserDefaultsUtils().timerTimeKey)
            timeLeft = 60
            
        }
        
    }
    
    // Start the timer
    func start() {
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeLeft > 0 {
                self.timeLeft -= 1.0
                
            }else{
                self.media.startRepeatingVibration()
                self.media.playSound("timer_sound.wav", repeatSound: true)
                
                self.state = .finished
                timer.invalidate()
                self.timeLeft = 0
                
            }
            
        }
        
    }
    
    // Pause the timer
    func pause() {
        state = .paused
        timer.invalidate()
        
    }
    
    // Reset the timer
    func reset(){
        state = .stopped
        timer.invalidate()
        timeLeft = 60
        
        if let sound = media.sound {
            sound.stop()
            
        }
        media.stopRepeatingVibration()
        
    }

}

// CountdownTimer states
enum CountdownTimerStates {
    case running
    case finished
    case stopped
    case paused
}
