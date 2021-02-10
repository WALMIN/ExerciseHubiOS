//
//  PopoverSetTime.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-09.
//

import SwiftUI

struct PopoverSetTime: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var timer = CountTimer()
    @State var time = 0.0
    
    var body: some View {
        VStack {
            // Show the title
            Text("Set time").font(.title2)
            Spacer()
            
            HStack {
                // Remove 1 second if the time is above 0 seconds
                Button(action: {
                    if time > 1 { time -= 1 }
                    
                }) {
                    ZStack {
                        Color("RemoveColor")
                        Image(systemName: "minus").foregroundColor(.white)
                    
                    }
                    .frame(width: 32, height: 32)
                    .cornerRadius(32)
                    .padding()
                    
                }
                
                Spacer()
                
                // Show time
                Text(Utils().secondsToHMS(time)).font(.title)
                
                Spacer()
                
                // Add 1 second button
                Button(action: {
                    time += 1
                    
                }) {
                    ZStack {
                        Color("AddColor")
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    
                    }
                    .frame(width: 32, height: 32)
                    .cornerRadius(32)
                    .padding()
                    
                }
                
            }
            
            Spacer()
            
            // Save new time & dismiss
            Button(action: {
                timer.timeLeft = time
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Save")
                
            }
            
        }
        .padding()
        
    }
    
}

struct PopoverSetTime_Previews: PreviewProvider {
    static var previews: some View {
        PopoverSetTime()
        
    }
    
}

