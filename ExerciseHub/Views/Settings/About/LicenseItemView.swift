//
//  LicenseItemView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct LicenseItemView: View {
    
    var title: String
    var by: String
    var license: String
    var link: String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            VStack(alignment: .leading) {
                Text("• \(title)")
                    .font(.body)
                    .fontWeight(.bold)
                    .fixedSize()
                
                Text(by)
                    .font(.callout)
                    .fixedSize()
                
                Text(license)
                    .font(.callout)
                    .fixedSize()
                
                Text(link)
                    .font(.callout)
                    .foregroundColor(.blue)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            .foregroundColor(Color(UIColor.label))
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
        
        }
            
    }
    
}

struct LicenseItemView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseItemView(title: "", by: "", license: "", link: "")
        
    }
    
}
