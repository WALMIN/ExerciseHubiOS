//
//  Stopwatch.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-08.
//

import Foundation

class Stopwatch: ObservableObject {

    @Published var state: StopwatchStates = .stopped
    @Published var timeElapsed: Double = 0
    
    var timer = Timer()
    
    // Start the timer
    func start() {
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.timeElapsed += 0.01
            
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
        timeElapsed = 0
        
    }

}

// Stopwatch states
enum StopwatchStates {
    case running
    case stopped
    case paused
}
