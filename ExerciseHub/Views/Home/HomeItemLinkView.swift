//
//  HomeItemLinkView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-04-09.
//

import SwiftUI

struct HomeItemLinkView: View {
    
    var systemIcon: Bool
    var icon: String
    var title: String
    var text: String
    
    var link: String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        if systemIcon {
                            Image(systemName: icon)
                                .resizable()
                                .foregroundColor(.accentColor)
                                .frame(width: 20, height: 20)
                            
                        } else {
                            Image(icon)
                                .resizable()
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
    
}

struct HomeItemLinkView_Previews: PreviewProvider {
    static var previews: some View {
        HomeItemLinkView(systemIcon: true, icon: "music.note.list", title: "The Official Workout Playlist", text: "The perfect playlist for your workouts is on Spotify, enjoy!", link: "https://open.spotify.com/playlist/1ttJQ1q4Jzs1JvTshkD4fK?si=cOA5WM5mTqaaxFpHJmqdmg")
        
    }
    
}
