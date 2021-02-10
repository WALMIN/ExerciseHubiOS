//
//  TimerView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timer = CountTimer()
    @State private var popoverSetTimeShowing = false
    
    var body: some View {
        VStack {
            // Time left on timer
            HStack {
                Text(Utils().secondsToMS(timer.timeLeft, extraZero: true))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                
            }

            HStack {
                // Reset timer if the timer is paused
                if timer.state == .paused {
                    Button(action: {
                        timer.reset()
                        timer.state = .stopped
                        
                    }) {
                        Text("Reset")
                            .textCase(.uppercase)
                            .foregroundColor(Color(UIColor.label))
                            .font(.system(size: 12))
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
                    ZStack {
                        Color(UIColor(.accentColor))
                        if timer.state == .paused || timer.state == .stopped {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                            
                        } else if timer.state == .finished {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                            
                        } else {
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                            
                        }
                    
                    }
                    .frame(width: 38, height: 38)
                    .cornerRadius(38)
                    .padding()
                    
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
                                .font(.system(size: 12))
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
                                .font(.system(size: 12))
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
