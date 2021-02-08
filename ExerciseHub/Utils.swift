//
//  Utils.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-08.
//

import Foundation

struct Utils {
    
    // Convert seconds to milliseconds
    func secondsToM(_ time: Double) -> String {
        var output = String(Int((time * 1000).truncatingRemainder(dividingBy: 1000))).prefix(2)
        
        if output == "0" {
            output = "00"
            
        }
        
        return String(output)
        
    }
    
    // Convert seconds to minutes & seconds
    func secondsToMS(_ time: Double) -> String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%01i:%02i", minutes, seconds)
        
    }
    
    // Convert seconds to hours, minutes & seconds
    func secondsToHMS(_ time: Double) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
}
