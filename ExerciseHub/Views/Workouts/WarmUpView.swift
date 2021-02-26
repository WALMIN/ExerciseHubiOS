//
//  WarmUpView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-20.
//

import SwiftUI

struct WarmUpView: View {
    
    @State var exercisesShowing = false
    @State private var selectedExercise: String? = nil
    
    let warmUpExercises = [ "Jumping jacks", "Mountain climbers",
                        "Low plank to high plank", "stretch/Wrist stretch",
                        "stretch/Biceps stretch", "stretch/Triceps stretch",
                        "stretch/Shoulder stretch", "stretch/Chest stretch",
                        "stretch/Upper legs stretch", "stretch/Lower legs stretch",
                        "stretch/Back stretch", "stretch/Abs stretch" ]
    
    var body: some View {
        ZStack {
            Color(UIColor(.white))
        
            VStack(alignment: .leading) {
                // Warm up title
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.black)
                    
                    Text("Remember to warm up")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: exercisesShowing ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation { exercisesShowing.toggle() }
                    
                }
                    
                // Warm up info & exercises with a video for each exercise
                if exercisesShowing {
                    Text("The warm up prepares your body for the workout, reduces the chance of injury and give you better performance.\n\nDo 20 seconds on every exercise.")
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
             
                    ForEach(warmUpExercises, id: \.self) { name in
                        HStack {
                            Image(systemName: "play.rectangle.fill")
                                .foregroundColor(.black)
                            
                            Text(name.replacingOccurrences(of: "stretch/", with: ""))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
                            
                        }
                        .padding(2)
                        .onTapGesture { selectedExercise = name }
                        
                    }
                    
                    // Extra item without a video
                    HStack {
                        Image(systemName: "rectangle.slash.fill")
                            .foregroundColor(.black)
                        
                        Text("Your weak spots")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
                        
                    }.padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                    
                }
                
            }.padding()
                
        }
        .cornerRadius(8)
        .sheet(item: $selectedExercise, content: { selectedExercise in
            SheetVideo(name: selectedExercise)

        })
        
    }
    
}

extension String: Identifiable {
    public var id: String { self }
}

struct WarmUpView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpView()
        
    }
    
}
