//
//  AboutView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-03-01.
//

import SwiftUI

struct AboutView: View {
    
    private var specialThanksTo = [ "Friskis&Svettis Sundsvall", "Joshua Ashagre", "Maja Filippa Bergene", "Mohamed Abdi Abdillahi" ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.title3)
                .fontWeight(.bold)
                .fixedSize()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
            // Special thanks
            Text("Special thanks to")
                .font(.body)
                .fontWeight(.bold)
                .fixedSize()
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            
            ForEach(specialThanksTo) { item in
                Text("• \(item)")
                    .font(.body)
                    .fixedSize()
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                
            }
            
            // Licenses
            Text("Licenses")
                .font(.body)
                .fontWeight(.bold)
                .fixedSize()
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            
            LicenseItemView(title: "Material Design Icons", by: "Google Inc.", license: "Apache License, Version 2.0", link: "https://github.com/google/material-design-icons")
            LicenseItemView(title: "SDWebImageSwiftUI", by: "DreamPiggy", license: "MIT License", link: "https://github.com/SDWebImage/SDWebImageSwiftUI")
            
        }
        
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
        
    }
    
}
