//
//  LibraryView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct LibraryView: View {
    
    @ObservedObject var fetchLibrary = FetchLibrary()
    
    @State var searchText = ""

    var body: some View {
        VStack {
            ScrollView {
                // Show no exercises text if the list is empty
                if fetchLibrary.list.count == 0 {
                    HStack {
                        Spacer()
                        VStack {
                            Text("No exercises to show").padding()
                            Text("Try again later")
                            
                        }
                        Spacer()
                        
                    }
                    
                // Show textfield & list
                } else {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
                            .foregroundColor(.gray)
                        
                        ZStack(alignment: .leading) {
                            if searchText.isEmpty {
                                Text("Search by name...").foregroundColor(.gray)
                                
                            }
                            TextField("", text: $searchText).foregroundColor(.black)
                            
                        }
                        
                    }
                    .padding(10)
                    .background(Color("ItemColor"))
                    .cornerRadius(8)
                    .padding(EdgeInsets(top: 6, leading: 14, bottom: 0, trailing: 14))
                    
                    
                    LazyVStack {
                        ForEach(fetchLibrary.list.filter({
                                searchText.isEmpty ?
                                 true : $0.name.lowercased().contains(searchText.lowercased())})) { item in
                        
                            LibraryItemView(item: item)
                        
                        }
                            
                    }.padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                    
                }
                
            }
            
        }
        
    }
    
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
