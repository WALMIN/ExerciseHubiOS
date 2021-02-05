//
//  LibraryView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct LibraryView: View {
    
    @State var searchText = ""
    @ObservedObject var fetchLibrary = FetchLibrary()

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                    .colorMultiply(Color(UIColor.label))
                TextField("Search by name...", text: $searchText)
            }
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.label), lineWidth: 1))
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            
            List(fetchLibrary.list.filter({
                    searchText.isEmpty ? true :
                    $0.name.lowercased().contains(searchText.lowercased())})) { item in
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
