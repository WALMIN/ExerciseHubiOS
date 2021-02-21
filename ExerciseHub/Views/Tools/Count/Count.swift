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
    @Published var countTo: Int = UserDefaults.standard.integer(forKey: UserDefaultsUtils().countKey)
    @Published var delay: Double = UserDefaults.standard.double(forKey: UserDefaultsUtils().countDelayKey)
    
    private var timer = Timer()
    
    init() {
        if countTo == 0 {
            UserDefaults.standard.set(10, forKey: UserDefaultsUtils().countKey)
            countTo = 10
            
        }
        
        if delay == 0 {
            UserDefaults.standard.set(1000, forKey: UserDefaultsUtils().countDelayKey)
            delay = 10
            
        }
        
    }
    
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
