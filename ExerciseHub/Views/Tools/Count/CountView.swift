//
//  CountView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct CountView: View {
    
    let userDefaults = UserDefaults.standard
    
    @ObservedObject private var count = Count()
    
    var body: some View {
        VStack {
            // Setup counting
            if count.state == .stopped {
                // Count
                Text("Count").font(.caption)
                
                HStack {
                    // Remove 1 countTo if it is above 0
                    Button(action: {
                        if count.countTo > 1 {
                            count.countTo -= 1
                            userDefaults.set(count.countTo, forKey: UserDefaultsUtils().countKey)
                            
                        }
                        
                    }) {
                        SetTimeButtonView(color: "RemoveColor", icon: "minus")
                        
                    }
                    
                    // Show count
                    Text("\(count.countTo)")
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(width: 128)
                    
                    // Add 1 countTo button
                    Button(action: {
                        count.countTo += 1
                        userDefaults.set(count.countTo, forKey: UserDefaultsUtils().countKey)
                        
                    }) {
                        SetTimeButtonView(color: "AddColor", icon: "plus")
                        
                    }
                    
                }
                
                // Delay
                Text("Delay").font(.caption)
                
                HStack {
                    // Remove 100 delay if the delay is above 500
                    Button(action: {
                        if count.delay > 500 {
                            count.delay -= 100
                            userDefaults.set(count.delay, forKey: UserDefaultsUtils().countDelayKey)
                            
                        }
                        
                    }) {
                        SetTimeButtonView(color: "RemoveColor", icon: "minus")
                        
                    }
                    
                    // Show delay
                    VStack {
                        Text("\(Int(count.delay))")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 128)
                        
                        Text("ms").font(.caption).padding(-4)
                        
                    }
                        
                    // Add 1 delay button
                    Button(action: {
                        count.delay += 100
                        userDefaults.set(count.delay, forKey: UserDefaultsUtils().countDelayKey)
                        
                    }) {
                        SetTimeButtonView(color: "AddColor", icon: "plus")
                        
                    }
                    
                }
                
            // Counting running
            } else {
                Text("\(count.count)")
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                
            }
            
            // Start/stop button based on current mode
            Button(action: {
                if count.state == .stopped {
                    count.start()
                    
                } else {
                    count.reset()
                    
                }
                
            }) {
                if count.state == .stopped {
                    PlayButtonView(icon: "play.fill")
                    
                } else {
                    PlayButtonView(icon: "stop.fill")
                    
                }
                
            }
            
        }.onAppear {
            if count.countTo == 0 {
                userDefaults.set(10, forKey: UserDefaultsUtils().countKey)
                count.countTo = 3
                
            }
            
            if count.delay == 0 {
                userDefaults.set(1000, forKey: UserDefaultsUtils().countDelayKey)
                count.delay = 60
                
            }
            
        }
        
    }
    
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
        
    }
    
}
