//
//  AboutLinkView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-02.
//

import SwiftUI

struct AboutLinkView: View {
    
    var title: String
    var link: String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            VStack(alignment: .leading) {
                Text("\(title)")
                    .font(.body)
                    .fontWeight(.bold)
                    .fixedSize()
                
            }
        
        }
        
    }
    
}

struct AboutLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AboutLinkView(title: "", link: "")
    }
}
