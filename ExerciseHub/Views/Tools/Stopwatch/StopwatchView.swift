//
//  StopwatchView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct StopwatchView: View {
    
    @ObservedObject private var stopwatch = Stopwatch()
    @State var lapList: [LapModel] = []
    @State var lapListShowing = false
    
    var body: some View {
        VStack {
            
            // Time elapsed on stopwatch
            HStack {
                Text(Utils().secondsToHMS(stopwatch.timeElapsed))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                
                Text(Utils().secondsToM(stopwatch.timeElapsed))
                    .font(.system(size: 32))
                
            }

            HStack {
                // Reset stopwatch & lap list if the stopwatch is paused
                Button(action: {
                    if stopwatch.state == .paused {
                        stopwatch.reset()
                        lapList = []
                        withAnimation { lapListShowing = false }
                        
                    }
                    
                }) {
                    Text("Reset")
                        .textCase(.uppercase)
                        .foregroundColor(Color(UIColor.label))
                        .font(.body)
                        .padding()
                }
                
                // Start/pause button based on current mode
                Button(action: {
                    if stopwatch.state == .stopped || stopwatch.state == .paused {
                        stopwatch.start()
                        
                    } else {
                        stopwatch.pause()
                        
                    }
                    
                }) {
                    if stopwatch.state == .stopped || stopwatch.state == .paused {
                        PlayButtonView(icon: "play.fill", size: 38)
                        
                    } else {
                        PlayButtonView(icon: "pause.fill", size: 38)
                        
                    }
                    
                }
                
                // Add item to lap list
                Button(action: {
                    if stopwatch.state == .running {
                        lapList.append(LapModel(position: (lapList.count), time: stopwatch.timeElapsed))
                        
                        withAnimation { lapListShowing = true }
                        
                    }
                    
                }) {
                    Text("Lap")
                        .textCase(.uppercase)
                        .foregroundColor(Color(UIColor.label))
                        .font(.body)
                        .padding()
                    
                }
                
            }
            
            // Lap list
            if lapListShowing {
                List(lapList){ item in
                    HStack {
                        Spacer()
                        
                        Text("#\(item.position + 1)")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                        
                        Text("\(Utils().secondsToHMS(item.time)).\(Utils().secondsToM(item.time))")
                            .font(.system(size: 24))
                        
                        Spacer()
                        
                    }
                    
                }
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    
            }
            
        }
            
    }

}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
        
    }
    
}
