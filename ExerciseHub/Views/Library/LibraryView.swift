//
//  LibraryView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct LibraryView: View {
    
    @ObservedObject var fetchLibrary = FetchLibrary()

    var body: some View {
        ZStack {
            List(fetchLibrary.list) { item in
                LibraryItemView(item: item)
                
            }
            
        }
        
    }
    
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
