//
//  TimerView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timer = CountdownTimer()
    @State private var popoverSetTimeShowing = false
    
    var body: some View {
        VStack {
            // Time left on timer
            HStack {
                Text(Utils().secondsToHMS(timer.timeLeft, extraZero: true))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                
            }

            HStack {
                // Reset timer if the timer is paused
                if timer.state == .paused {
                    Button(action: {
                        timer.reset()
                        
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
                
                // Start/reset/pause button based on current mode
                Button(action: {
                    if timer.state == .stopped || timer.state == .paused {
                        timer.start()
                        
                    } else if timer.state == .finished {
                        timer.reset()
                        
                    } else {
                        timer.pause()
                        
                    }
                    
                }) {
                    if timer.state == .paused || timer.state == .stopped {
                        PlayButtonView(icon: "play.fill", size: 38)
                        
                    } else if timer.state == .finished {
                        PlayButtonView(icon: "stop.fill", size: 38)
                        
                    } else {
                        PlayButtonView(icon: "pause.fill", size: 38)
                        
                    }
                    
                }
                
                // Set time button
                if timer.state == .paused || timer.state == .stopped {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Button(action: {
                            popoverSetTimeShowing = true
                            
                        }) {
                            Text("Set time")
                                .textCase(.uppercase)
                                .foregroundColor(Color(UIColor.label))
                                .font(.body)
                                .padding()
                            
                        }.popover(isPresented: $popoverSetTimeShowing) {
                            PopoverSetTime(timer: timer, time: timer.timeLeft)
                        }
                        
                    } else {
                        Button(action: {
                            popoverSetTimeShowing = true
                            
                        }) {
                            Text("Set time")
                                .textCase(.uppercase)
                                .foregroundColor(Color(UIColor.label))
                                .font(.body)
                                .padding()
                            
                        }.sheet(isPresented: $popoverSetTimeShowing) {
                            PopoverSetTime(timer: timer, time: timer.timeLeft)
                            
                        }
                        
                    }
                
                } else {
                    BlankButtonView(title: "Set time")
                    
                }
                
            }
            
        }
        
    }
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
        
    }
    
}
