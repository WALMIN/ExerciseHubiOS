//
//  LibraryItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct LibraryItemView: View {
    
    @State var videoShowing = false
    
    var item: LibraryModel
        
    var body: some View {
        ZStack {
            Color(UIColor(.white))
            HStack {
                VStack {
                    ImageViewURL("https://walmin.com/exercisehub/resources/library/gif/\(item.name.lowercased().replacingOccurrences(of: " ", with: "_")).gif")
                        .clipShape(Circle())
                    
                }
                .frame(width: 44, height: 44)
                
                Text(item.name)
                    .font(.title3)
                    .foregroundColor(.accentColor)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                
                Spacer()
            
            }
            .padding(12)
            
        }
        .onTapGesture {
            videoShowing = true
            
        }
        .cornerRadius(8)
        .sheet(isPresented: $videoShowing) {
            SheetVideo(name: item.name)
            
        }
        
    }
    
}

struct LibraryItemView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryItemView(item: LibraryModel(name: "Push ups"))
        
    }
    
}
