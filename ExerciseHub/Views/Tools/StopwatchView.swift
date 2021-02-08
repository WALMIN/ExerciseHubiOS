//
//  StopwatchView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct StopwatchView: View {
    
    @ObservedObject private var stopwatch = Stopwatch()
    
    var body: some View {
        VStack {
            
            // Time elapsed on stopwatch
            HStack {
                Text(Utils().secondsToMS(stopwatch.timeElapsed))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                
                Text(Utils().secondsToM(stopwatch.timeElapsed))
                    .font(.system(size: 32))
                
            }

            HStack {
                // Reset stopwatch if timer is paused
                Button(action: {
                    if stopwatch.mode == .paused {
                        stopwatch.reset()
                        
                    }
                    
                }) {
                    Text("Reset")
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                }
                
                // Start/pause button based on current mode
                Button(action: {
                    if stopwatch.mode == .stopped || stopwatch.mode == .paused {
                        stopwatch.start()
                        
                    } else {
                        stopwatch.pause()
                        
                    }
                    
                }) {
                    ZStack {
                        Color(UIColor(.accentColor))
                        if stopwatch.mode == .stopped || stopwatch.mode == .paused {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                            
                        } else {
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                            
                        }
                    
                    }
                    .frame(width: 48, height: 48)
                    .cornerRadius(48)
                    .padding()
                    
                }
                
                // Add item to lap list
                Button(action: {
                    
                    
                }) {
                    Text("Lap")
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                }
                
            }
            
        }
            
    }

}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
        
    }
    
}
