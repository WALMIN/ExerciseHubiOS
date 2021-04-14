//
//  ToolsTitleView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-24.
//

import SwiftUI

struct ToolsTitleView: View {
    
    var title = ""
    
    var body: some View {
        Text(title)
            .font(.caption)
            .textCase(.uppercase)
            .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
        
        Spacer()
        
    }
    
}


struct ToolsTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsTitleView()
        
    }
    
}
