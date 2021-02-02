//
//  LibraryItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct LibraryItemView: View {
    
    var item: LibraryModel
        
        var body: some View {
            ZStack {
                Color(UIColor(.white))
                HStack {
                    VStack {
                        ImageViewURL("https://walmin.com/exercisehub/resources/library/gif/" + item.name.lowercased().replacingOccurrences(of: " ", with: "_") + ".gif")
                            .clipShape(Circle())
                        
                    }
                    .frame(width: 44, height: 44)
                    
                    Text(item.name)
                        .font(.system(size: 16))
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    
                    Spacer()
                
                }
                .padding(12)
                
            }
            .cornerRadius(8)
            
        }
    
}

struct LibraryItemView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryItemView(item: LibraryModel(name: "Push ups"))
        
    }
    
}
