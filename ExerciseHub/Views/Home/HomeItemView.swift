//
//  HomeItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-16.
//

import SwiftUI

struct HomeItemView: View {
    
    var systemIcon: Bool
    var icon: String
    var title: String
    var text: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    if systemIcon {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(width: 20, height: 20)
                        
                    } else {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(width: 20, height: 20)
                        
                    }
                    
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .textCase(.uppercase)
                        .lineLimit(1)
                    
                    Spacer()
                    
                }
                
                HStack {
                    Text(text)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                 
                    Spacer()
                    
                }
                
            }.padding(12)
            
        }
        .background(Color("ItemColor"))
        .cornerRadius(8)
        
    }
    
}

struct HomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeItemView(systemIcon: true, icon: "music.note.list", title: "The Official Workout Playlist", text: "The perfect playlist for your workouts is on Spotify, enjoy!")
        
    }
    
}
