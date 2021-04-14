//
//  HomeView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-16.
//

import SwiftUI

struct HomeView: View {
    
    private var greetings = ["Hello!", "Hi!", "Welcome!", "What's up?", "Hey!", "Good day!", "Have a great day!", "Have a good day!"]
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \History.timestamp, ascending: true)], animation: .default)
    private var history: FetchedResults<History>
    @State private var shareSheetShowing = false
    
    @ObservedObject var fetchWorkouts = FetchWorkouts()
    @ObservedObject var fetchLibrary = FetchLibrary()
    
    @State private var selectedExercise: String? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    // Greeting
                    ZStack {
                        HStack {
                            Text(greetings[Int.random(in: 0..<greetings.count)])
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                         
                            Spacer()
                            
                        }.padding(12)
                        
                    }
                    .background(Color("AccentColor"))
                    .cornerRadius(8)
                    
                    // You completed
                    ZStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .foregroundColor(.accentColor)
                                    .frame(width: 20, height: 20)
                                
                                Text("You completed")
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor)
                                    .textCase(.uppercase)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                            }
                            
                            HStack {
                                Text(history.count > 0 ? history[history.count - 1].wrappedTitle : "No workout yet, get moving!")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                             
                                Spacer()
                                
                            }
                            
                            if history.count > 0 {
                                HStack {
                                    if let timestamp = history[history.count - 1].timestamp {
                                        Text("on \(timestamp, formatter: Utils().dateFormatter)")
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                        
                                    }
                                 
                                    Spacer()
                                    
                                }
                                
                            }
                            
                        }.padding(12)
                        
                    }
                    .background(Color("ItemColor"))
                    .cornerRadius(8)
                    .onTapGesture {
                        if history.count > 0 {
                            shareSheetShowing = true
                            
                        }
                        
                    }
                    .background(EmptyView().sheet(isPresented: $shareSheetShowing) {
                        SheetShare(activityItems: ["I've completed \"" + history[history.count - 1].wrappedTitle + "\" with Exercise Hub." + "\n\n" +
                                                "Get the app & workout just like me!" + "\n\n" +
                                                "Download - " + "https://tinyurl.com/pv6bck4x"])
                        
                    })
                    
                    // Workout of the day
                    NavigationLink(destination: DefaultExercisesView(title: fetchWorkouts.workoutOfTheDay ?? "Full body", description: fetchWorkouts.workoutOfTheDayDesc ?? "- Rounds: 1\n- Exercises: 10\n- Length: 60 minutes", fetchExercises: FetchExercises(id: fetchWorkouts.workoutOfTheDayID ?? "0"))) {
                        HomeItemView(systemIcon: true, icon: "doc.plaintext.fill", title: "Workout Of The Day", text: fetchWorkouts.workoutOfTheDay ?? "")
                        
                    }
                        
                    // Exercise of the day
                    HomeItemView(systemIcon: false, icon: "tools", title: "Exercise Of The Day", text: fetchLibrary.exerciseOfTheDay ?? "")
                        .onTapGesture{ selectedExercise = fetchLibrary.exerciseOfTheDay }
                        .background(EmptyView().sheet(item: $selectedExercise, content: { selectedExercise in
                                SheetVideo(name: selectedExercise)

                            })
                        
                        )
                        
                    // Links
                    HomeItemLinkView(systemIcon: false, icon: "instagram", title: "The Official Instagram Profile", text: "Follow @exercise.hub on Instagram to stay up to date with new features and more!", link: "https://www.instagram.com/exercise.hub")
                    HomeItemLinkView(systemIcon: true, icon: "music.note.list", title: "The Official Workout Playlist", text: "The perfect playlist for your workouts is on Spotify, enjoy!", link: "https://open.spotify.com/playlist/1ttJQ1q4Jzs1JvTshkD4fK?si=cOA5WM5mTqaaxFpHJmqdmg")
                    
                    // Advertisement
                    ZStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("tools")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.accentColor)
                                    .frame(width: 20, height: 20)
                                
                                Text("Advertisement")
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor)
                                    .textCase(.uppercase)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                            }
                            
                            HStack {
                                Text("Loading...")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding()
                                
                                // AD
                                
                            }
                            
                        }.padding(12)
                        
                    }
                    .background(Color("ItemColor"))
                    .cornerRadius(8)
                    
                }.padding(EdgeInsets(top: 6, leading: 14, bottom: 0, trailing: 14))
                
            }.navigationTitle("\(Date(), formatter: Utils().dayFormatter)")
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
    
}
