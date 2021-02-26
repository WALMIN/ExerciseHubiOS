//
//  HistoryItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-26.
//

import SwiftUI

struct HistoryItemView: View {
    
    var history: History
    
    var body: some View {
        ZStack {
            Color(UIColor(.clear))
            
            VStack {
                HStack {
                    Circle()
                        .foregroundColor(.accentColor)
                        .frame(width: 16, height: 16)
                        .fixedSize()
                    
                    VStack {
                        HStack {
                            // Workout title
                            Text("\(history.wrappedTitle)")
                                .font(.body)
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .lineLimit(1)
                            
                            Spacer()
                            
                        }
                        
                        HStack {
                            // History date & time finished
                            if let timestamp = history.timestamp {
                                Text("\(timestamp, formatter: Utils().dateFormatter)")
                                    .font(.caption)
                                
                            }
                         
                            Spacer()
                            
                        }.padding(EdgeInsets(top: 0.5, leading: 0, bottom: 0, trailing: 0))
                        
                    }
                    
                }
                
            }.padding(8)
            
        }
        
    }
    
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView(history: History())
        
    }
    
}
