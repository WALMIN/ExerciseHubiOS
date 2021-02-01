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
                        Image(systemName: "person.circle.fill")
                        
                        
                    }
                    .frame(width: 44, height: 44)
                    
                    Text(item.name)
                        .font(.system(size: CGFloat(16.0)))
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .lineLimit(1)
                        .padding()
                    
                    Spacer()
                
                }
                
            }
            .cornerRadius(8)
            
        }
    
}

struct LibraryItemView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryItemView(item: LibraryModel(name: "Push ups"))
        
    }
    
}
