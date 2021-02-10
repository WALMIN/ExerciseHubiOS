//
//  IntervalTimerSetupView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-10.
//

import SwiftUI

struct IntervalTimerSetupView: View {
    
    @State var rounds = 1
    @State var work = 3599.0
    @State var rest = 15.0
    
    var body: some View {
        VStack {
            // Rounds
            Text("Rounds").font(.system(size: 12))
            
            HStack {
                // Remove 1 round if the round is above 0 seconds
                Button(action: {
                    if rounds > 1 { rounds -= 1 }
                    
                }) {
                    SetTimeButtonView(color: "RemoveColor", icon: "minus")
                    
                }
                
                // Show rounds
                Text("\(rounds)")
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .frame(width: 128)
                
                // Add 1 round button
                Button(action: {
                    rounds += 1
                    
                }) {
                    SetTimeButtonView(color: "AddColor", icon: "plus")
                    
                }
                
            }
            
            // Work
            Text("Work").font(.system(size: 12))
            
            HStack {
                // Remove 1 second if the time is above 0 seconds
                Button(action: {
                    if work > 1 { work -= 1 }
                    
                }) {
                    SetTimeButtonView(color: "RemoveColor", icon: "minus")
                    
                }
                
                // Show time
                Text(Utils().secondsToHMS(work))
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .frame(width: 128)
                
                // Add 1 second button
                Button(action: {
                    work += 1
                    
                }) {
                    SetTimeButtonView(color: "AddColor", icon: "plus")
                    
                }
                
            }
            
            // Rest
            Text("Rest").font(.system(size: 12))
            
            HStack {
                // Remove 1 second if the time is above 0 seconds
                Button(action: {
                    if rest > 1 { rest -= 1 }
                    
                }) {
                    SetTimeButtonView(color: "RemoveColor", icon: "minus")
                    
                }
                
                // Show time
                Text(Utils().secondsToHMS(rest))
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .frame(width: 128)
                
                // Add 1 second button
                Button(action: {
                    rest += 1
                    
                }) {
                    SetTimeButtonView(color: "AddColor", icon: "plus")
                    
                }
                
            }
            
            // Play button
            Button(action: {
                
                
            }) {
                PlayButtonView(color: UIColor(.accentColor), icon: "play.fill", size: 38)
                
            }
            
        }
        
    }
    
}

struct IntervalTimerSetupView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimerSetupView()
        
    }
    
}
