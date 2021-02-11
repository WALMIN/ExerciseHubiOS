//
//  Utils.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-08.
//

import Foundation
import AudioToolbox

struct Utils {
    
    // Convert seconds to milliseconds
    func secondsToM(_ time: Double) -> String {
        var output = String(Int((time * 1000).truncatingRemainder(dividingBy: 1000))).prefix(2)
        
        if output == "0" {
            output = "00"
            
        }
        
        return String(output)
        
    }
    
    // Convert seconds to hours, minutes & seconds
    func secondsToHMS(_ time: Double, extraZero: Bool = false) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if hours > 0 {
            return String(format:"%01i:%02i:%02i", hours, minutes, seconds)
            
        } else {
            if extraZero {
                return String(format:"%02i:%02i", minutes, seconds)
                
            }else{
                return String(format:"%01i:%02i", minutes, seconds)
            
            }
            
        }
        
    }
    
    func vibrate(strength: Int = 0) {
        // Strong
        if strength == 1 {
            AudioServicesPlaySystemSound(1520)
            
        // Three week
        } else if strength == 2 {
            AudioServicesPlaySystemSound(1521)
            
        // Week
        } else {
            AudioServicesPlaySystemSound(1519)
        
        }
            
    }
    
}
