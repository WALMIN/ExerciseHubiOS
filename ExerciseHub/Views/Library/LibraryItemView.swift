//
//  LibraryItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI
import SDWebImageSwiftUI

struct LibraryItemView: View {
    
    @State var videoShowing = false
    @State var imageAnimating = true
    
    var item: LibraryModel
        
    // Library list item with an animated image & title
    var body: some View {
        ZStack {
            Color(UIColor(.white))
            HStack {
                VStack {
                    WebImage(url: URL(string: "https://walmin.com/exercisehub/resources/library/gif/\(item.name.lowercased().replacingOccurrences(of: " ", with: "_")).gif"), isAnimating: $imageAnimating)
                        .placeholder{ Image(systemName: "gobackward").foregroundColor(.black) }
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                    
                }
                .frame(width: 44, height: 44, alignment: .center)
                
                Text(item.name)
                    .font(.body)
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
