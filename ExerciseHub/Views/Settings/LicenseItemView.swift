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
                    .font(.caption2)
                    .fixedSize()
                
                Text(license)
                    .font(.caption2)
                    .fixedSize()
                
                Text(link)
                    .font(.caption)
                    .foregroundColor(.blue)
                    .fixedSize()
                
            }
            .foregroundColor(Color(UIColor.label))
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
        
        }
            
    }
    
}

struct LicenseItemView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseItemView(title: "", by: "", license: "", link: "")
        
    }
    
}
