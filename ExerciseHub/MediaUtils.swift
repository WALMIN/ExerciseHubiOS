//
//  MediaUtils.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-21.
//

import Foundation
import AVKit

class MediaUtils {
    
    var sound: AVAudioPlayer?
    var vibrationTimer: Timer?
    
    // Play a sound
    func playSound(_ file: String, repeatSound: Bool = false){
        guard let path = Bundle.main.path(forResource: "\(file)", ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            sound = try AVAudioPlayer(contentsOf: url)
            if let sound = sound {
                if repeatSound { sound.numberOfLoops = -1 }
                sound.play()
                
            }
            
        } catch {
            print(error)
        }
        
    }
    
    // Start the repeating vibration
    func startRepeatingVibration() {
        if !UserDefaults.standard.bool(forKey: UserDefaultsUtils().vibrationKey) {
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { timer in
                AudioServicesPlaySystemSound(1520)
                
                print("Vibration")
                   
            }
         
        }
            
    }
    
    // Stop the repeating vibration
    func stopRepeatingVibration() {
        if let timer = vibrationTimer {
            timer.invalidate()
            
        }
            
    }
    
    // Vibrate device
    func vibrate(strength: Int = 0) {
        if !UserDefaults.standard.bool(forKey: UserDefaultsUtils().vibrationKey) {
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
    
}
