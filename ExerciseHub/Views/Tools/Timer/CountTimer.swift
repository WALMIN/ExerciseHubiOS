//
//  CountTimer.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import Foundation

class CountTimer: ObservableObject {

    @Published var state: CountTimerStates = .stopped
    @Published var timeLeft: Double = 60
    private var timer = Timer()
    
    // Start the timer
    func start() {
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(self.timeLeft > 0){
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

// CountTimer states
enum CountTimerStates {
    case running
    case finished
    case stopped
    case paused
}
