//
//  IntervalTimer.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import Foundation

class IntervalTimer: ObservableObject {

    @Published var timerState: TimerStates = .work
    @Published var state: IntervalTimerStates = .stopped
    
    @Published var roundsLeft = 3
    @Published var workTimeLeft: Double = 60
    @Published var restTimeLeft: Double = 30
    
    private var timer = Timer()
    
    // Start the timer
    func start() {
        state = .running
        self.timerState = .work
        
        let work = self.workTimeLeft
        let rest = self.restTimeLeft
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            // Work
            if self.timerState == .work {
                if self.workTimeLeft > 0 {
                    self.workTimeLeft -= 1
                    
                } else {
                    self.timerState = .rest
                    self.restTimeLeft = rest
                    
                }
                
            // Rest
            } else {
                if self.restTimeLeft > 0 {
                    self.restTimeLeft -= 1
                    
                } else {
                    self.roundsLeft -= 1
                    
                    if self.roundsLeft >= 1 {
                        self.timerState = .work
                        self.workTimeLeft = work
                        
                    } else {
                        self.reset()
                        
                    }
                    
                }
                
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
        
    }

}

// Timer states
enum TimerStates {
    case work
    case rest
}

// Interval timer states
enum IntervalTimerStates {
    case running
    case stopped
    case paused
}
