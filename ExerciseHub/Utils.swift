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
    
    // Format date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        return formatter
        
    }()
    
    // Format date only
    let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        return formatter
        
    }()
    
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter
        
    }()
    
}
