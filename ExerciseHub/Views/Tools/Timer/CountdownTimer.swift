//
//  CountdownTimer.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import Foundation

class CountdownTimer: ObservableObject {

    @Published var state: CountdownTimerStates = .stopped
    @Published var timeLeft: Double = 60
    private var timer = Timer()
    
    // Start the timer
    func start() {
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeLeft > 0 {
                self.timeLeft -= 1.0
                
            }else{
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
        
    }

}

// CountdownTimer states
enum CountdownTimerStates {
    case running
    case finished
    case stopped
    case paused
}
