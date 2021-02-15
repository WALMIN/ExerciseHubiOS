//
//  IntervalTimerView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct IntervalTimerView: View {
    
    // Setup
    @State var rounds = 3
    @State var work: Double = 60
    @State var rest: Double = 30
    
    // Running
    @ObservedObject var intervalTimer = IntervalTimer()
    @State private var time: Double = 0
    
    var body: some View {
        VStack {
            // Setup interval timer
            if intervalTimer.state == .stopped {
                VStack {
                    // Rounds
                    Text("Rounds").font(.caption)
                    
                    HStack {
                        // Remove 1 round if the round is above 0 seconds
                        Button(action: { if rounds > 1 { rounds -= 1 } }) {
                            SetTimeButtonView(color: "RemoveColor", icon: "minus")
                            
                        }
                        
                        // Show rounds
                        Text("\(rounds)")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 128)
                        
                        // Add 1 round button
                        Button(action: { rounds += 1 }) {
                            SetTimeButtonView(color: "AddColor", icon: "plus")
                            
                        }
                        
                    }
                    
                    // Work
                    Text("Work").font(.caption)
                    
                    HStack {
                        // Remove 1 second if the time is above 0 seconds
                        Button(action: { if work > 1 { work -= 1 } }) {
                            SetTimeButtonView(color: "RemoveColor", icon: "minus")
                            
                        }
                        
                        // Show time
                        Text(Utils().secondsToHMS(work))
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 128)
                        
                        // Add 1 second button
                        Button(action: { work += 1 }) {
                            SetTimeButtonView(color: "AddColor", icon: "plus")
                            
                        }
                        
                    }
                    
                    // Rest
                    Text("Rest").font(.caption)
                    
                    HStack {
                        // Remove 1 second if the time is above 0 seconds
                        Button(action: { if rest > 1 { rest -= 1 } }) {
                            SetTimeButtonView(color: "RemoveColor", icon: "minus")
                            
                        }
                        
                        // Show time
                        Text(Utils().secondsToHMS(rest))
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 128)
                        
                        // Add 1 second button
                        Button(action: { rest += 1 }) {
                            SetTimeButtonView(color: "AddColor", icon: "plus")
                            
                        }
                        
                    }
                    
                    // Play button
                    Button(action: {
                        intervalTimer.timerState = .getReady
                        intervalTimer.roundsLeft = rounds
                        intervalTimer.workTimeLeft = work
                        intervalTimer.restTimeLeft = rest
                        intervalTimer.start()
                        
                    }) {
                        PlayButtonView(icon: "play.fill")
                        
                    }
                    
                }
                
            // Interval timer running
            } else {
                VStack {
                    Spacer()
                    
                    // Get ready timer
                    if intervalTimer.timerState == .getReady {
                        VStack {
                            Text(Utils().secondsToHMS(intervalTimer.getReadyTimeLeft, extraZero: true))
                                .font(.system(size: 64))
                                .fontWeight(.bold)
                            
                            Text("Get ready!")
                                .font(.body)
                                .textCase(.uppercase)
                                .padding()
                            
                        }
                        
                    } else {
                        // Time left on timer
                        Text(Utils().secondsToHMS(intervalTimer.timerState == .work ? intervalTimer.workTimeLeft : intervalTimer.restTimeLeft, extraZero: true))
                            .font(.system(size: 64))
                            .fontWeight(.bold)
                            
                        HStack {
                            // Current round
                            Text("Round \(intervalTimer.roundsLeft)")
                                .font(.body)
                                .textCase(.uppercase)
                            
                            // Play/pause button
                            Button(action: {
                                if intervalTimer.state == .paused {
                                    intervalTimer.start()
                                    
                                } else {
                                    intervalTimer.pause()
                                    
                                }
                                
                            }) {
                                if intervalTimer.state == .paused {
                                    PlayButtonView(icon: "play.fill")
                                    
                                } else {
                                    PlayButtonView(icon: "pause.fill")
                                    
                                }
                                
                            }
                            
                            // Current state
                            Text(intervalTimer.timerState == .work ? "Work" : "Rest")
                                .font(.body)
                                .textCase(.uppercase)
                        
                        }
                        
                    }
                    
                    Spacer()
                    
                    if intervalTimer.state == .paused {
                        Button(action: {
                            intervalTimer.reset()
                            
                        }) {
                            Text("Reset")
                                .textCase(.uppercase)
                                .foregroundColor(Color(UIColor.label))
                                .font(.body)
                                .padding()
                            
                        }
                        
                    } else {
                        BlankButtonView(title: "Reset")
                        
                    }
                        
                }
                
            }
            
        }
        
    }
    
}

struct IntervalTimerView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimerView()
        
    }
    
}
