//
//  Count.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-11.
//

import Foundation

class Count: ObservableObject {

    @Published var state: CountStates = .stopped
    
    @Published var count: Int = 0
    @Published var countTo: Int = 10
    @Published var delay: Double = 1000
    
    private var timer = Timer()
    
    // Start
    func start() {
        state = .running
        
        timer = Timer.scheduledTimer(withTimeInterval: (self.delay / 1000), repeats: true) { timer in
            if self.count < self.countTo {
                self.count += 1
                
            } else {
                self.reset()
                
            }
            
        }
        
    }
    
    // Reset
    func reset(){
        state = .stopped
        timer.invalidate()
        count = 0
        
    }

}

// Count states
enum CountStates {
    case running
    case stopped
}
